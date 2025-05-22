using IQLink.Data;
using IQLink.Models;
using Microsoft.EntityFrameworkCore;
using System.Text;

namespace IQLink.Services
{
    public class DonationExportHelper
    {
        private readonly ILogger<DonationExportHelper> _logger;
        private readonly IServiceScopeFactory _scopeFactory;

        public DonationExportHelper(
            ILogger<DonationExportHelper> logger,
            IServiceScopeFactory scopeFactory)
        {
            _logger = logger;
            _scopeFactory = scopeFactory;
        }

        /// <summary>
        /// Exports a single donation record using the first enabled auto-export configuration
        /// </summary>
        public async Task ExportDonationAsync(DonationsData donation)
        {
            if (donation == null)
            {
                _logger.LogWarning("Cannot export null donation");
                return;
            }

            try
            {
                using var scope = _scopeFactory.CreateScope();
                var dbContext = scope.ServiceProvider.GetRequiredService<LipoDocDbContext>();

                // Get the first enabled auto-export configuration
                var autoExportConfig = await dbContext.ExportSettingsConfigs
                    .Where(c => c.AutoExportEnabled)
                    .OrderByDescending(c => c.IsDefault)
                    .ThenByDescending(c => c.LastUsedAt)
                    .FirstOrDefaultAsync();

                if (autoExportConfig == null)
                {
                    _logger.LogDebug("No auto-export configuration found for donation {DonationId}", donation.Id);
                    return;
                }

                _logger.LogInformation("Auto-exporting donation {DonationId} using config '{ConfigName}'",
                    donation.Id, autoExportConfig.Name);

                await ExportDonations(new List<DonationsData> { donation }, autoExportConfig);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error auto-exporting donation {DonationId}", donation.Id);
            }
        }

        /// <summary>
        /// Exports multiple donations using the specified configuration
        /// </summary>
        public async Task ExportDonations(List<DonationsData> donations, ExportSettingsConfig config)
        {
            if (donations == null || !donations.Any())
            {
                _logger.LogWarning("No donations to export");
                return;
            }

            if (config == null)
            {
                _logger.LogWarning("No export configuration provided");
                return;
            }

            try
            {
                _logger.LogInformation("Exporting {Count} donations using config '{ConfigName}' (Mode: {Mode})",
                    donations.Count, config.Name, config.AutoExportMode);

                // Deserialize export settings
                var selectedColumns = new List<string>();
                var columnOrder = new List<string>();

                if (!string.IsNullOrEmpty(config.SelectedColumnsJson))
                {
                    try
                    {
                        selectedColumns = System.Text.Json.JsonSerializer.Deserialize<List<string>>(config.SelectedColumnsJson) ?? new List<string>();
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError(ex, "Error deserializing selected columns JSON");
                        selectedColumns = GetDefaultColumns();
                    }
                }
                else
                {
                    selectedColumns = GetDefaultColumns();
                }

                if (!string.IsNullOrEmpty(config.ColumnOrderJson))
                {
                    try
                    {
                        columnOrder = System.Text.Json.JsonSerializer.Deserialize<List<string>>(config.ColumnOrderJson) ?? selectedColumns;
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError(ex, "Error deserializing column order JSON");
                        columnOrder = selectedColumns;
                    }
                }
                else
                {
                    columnOrder = selectedColumns;
                }

                // Determine export folder
                string exportFolder = GetExportFolder(config);
                if (!Directory.Exists(exportFolder))
                {
                    Directory.CreateDirectory(exportFolder);
                    _logger.LogInformation("Created export directory: {ExportFolder}", exportFolder);
                }

                // Export based on mode
                switch (config.AutoExportMode?.ToLower())
                {
                    case "individual_files":
                        await ExportIndividualFiles(donations, config, exportFolder, selectedColumns, columnOrder);
                        break;
                    case "daily_file":
                        await ExportDailyFile(donations, config, exportFolder, selectedColumns, columnOrder);
                        break;
                    case "single_file":
                    default:
                        await ExportSingleFile(donations, config, exportFolder, selectedColumns, columnOrder);
                        break;
                }

                // Update config last used time
                using var scope = _scopeFactory.CreateScope();
                var dbContext = scope.ServiceProvider.GetRequiredService<LipoDocDbContext>();
                var configToUpdate = await dbContext.ExportSettingsConfigs.FindAsync(config.Id);
                if (configToUpdate != null)
                {
                    configToUpdate.LastUsedAt = DateTime.Now;
                    await dbContext.SaveChangesAsync();
                }

                _logger.LogInformation("Successfully exported {Count} donations to {ExportFolder}",
                    donations.Count, exportFolder);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error exporting donations using config '{ConfigName}'", config.Name);
                throw;
            }
        }

        private async Task ExportSingleFile(List<DonationsData> donations, ExportSettingsConfig config,
            string exportFolder, List<string> selectedColumns, List<string> columnOrder)
        {
            string fileName = $"{config.CustomFileName ?? "Donations_Export"}.csv";
            string filePath = Path.Combine(exportFolder, fileName);

            bool fileExists = File.Exists(filePath);
            bool includeHeaders = config.IncludeHeaders && !fileExists;

            var csv = new StringBuilder();

            // Add headers if needed
            if (includeHeaders)
            {
                var headerParts = columnOrder.Select(column => $"\"{GetColumnDisplayName(column)}\"");
                csv.AppendLine(string.Join(GetDelimiter(config), headerParts));
            }

            // Add data rows
            foreach (var donation in donations)
            {
                var row = columnOrder.Select(column =>
                {
                    string value = GetPropertyValue(donation, column, config.DateFormat, config.TimeFormat);
                    return $"\"{value.Replace("\"", "\"\"")}\"";
                });
                csv.AppendLine(string.Join(GetDelimiter(config), row));
            }

            // Append to file
            await File.AppendAllTextAsync(filePath, csv.ToString(), Encoding.UTF8);
            _logger.LogDebug("Appended {Count} donations to {FilePath}", donations.Count, filePath);
        }

        private async Task ExportDailyFile(List<DonationsData> donations, ExportSettingsConfig config,
            string exportFolder, List<string> selectedColumns, List<string> columnOrder)
        {
            // Group donations by date
            var donationsByDate = donations.GroupBy(d => d.Timestamp.Date);

            foreach (var dateGroup in donationsByDate)
            {
                string dateStr = dateGroup.Key.ToString("yyyy_MM_dd");
                string fileName = $"{config.CustomFileName ?? "Donations_Export"}_{dateStr}.csv";
                string filePath = Path.Combine(exportFolder, fileName);

                bool fileExists = File.Exists(filePath);
                bool includeHeaders = config.IncludeHeaders && !fileExists;

                var csv = new StringBuilder();

                // Add headers if needed
                if (includeHeaders)
                {
                    var headerParts = columnOrder.Select(column => $"\"{GetColumnDisplayName(column)}\"");
                    csv.AppendLine(string.Join(GetDelimiter(config), headerParts));
                }

                // Add data rows for this date
                foreach (var donation in dateGroup.OrderBy(d => d.Timestamp))
                {
                    var row = columnOrder.Select(column =>
                    {
                        string value = GetPropertyValue(donation, column, config.DateFormat, config.TimeFormat);
                        return $"\"{value.Replace("\"", "\"\"")}\"";
                    });
                    csv.AppendLine(string.Join(GetDelimiter(config), row));
                }

                // Append to file
                await File.AppendAllTextAsync(filePath, csv.ToString(), Encoding.UTF8);
                _logger.LogDebug("Appended {Count} donations to daily file {FilePath}", dateGroup.Count(), filePath);
            }
        }

        private async Task ExportIndividualFiles(List<DonationsData> donations, ExportSettingsConfig config,
            string exportFolder, List<string> selectedColumns, List<string> columnOrder)
        {
            foreach (var donation in donations)
            {
                string donationId = donation.DonationIdBarcode ?? donation.Id.ToString();
                string fileName = $"{config.CustomFileName ?? "Donation"}_{donationId}_{DateTime.Now:yyyyMMdd_HHmmss}.csv";
                string filePath = Path.Combine(exportFolder, fileName);

                var csv = new StringBuilder();

                // Add headers
                if (config.IncludeHeaders)
                {
                    var headerParts = columnOrder.Select(column => $"\"{GetColumnDisplayName(column)}\"");
                    csv.AppendLine(string.Join(GetDelimiter(config), headerParts));
                }

                // Add data row
                var row = columnOrder.Select(column =>
                {
                    string value = GetPropertyValue(donation, column, config.DateFormat, config.TimeFormat);
                    return $"\"{value.Replace("\"", "\"\"")}\"";
                });
                csv.AppendLine(string.Join(GetDelimiter(config), row));

                // Write to individual file
                await File.WriteAllTextAsync(filePath, csv.ToString(), Encoding.UTF8);
                _logger.LogDebug("Exported donation {DonationId} to individual file {FilePath}", donation.Id, filePath);
            }
        }

        private string GetExportFolder(ExportSettingsConfig config)
        {
            string baseFolder = config.ExportFolderPath ?? "DonationsExport";

            if (!Path.IsPathRooted(baseFolder))
            {
                baseFolder = Path.Combine(
                    Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
                    baseFolder
                );
            }

            return baseFolder;
        }

        private string GetDelimiter(ExportSettingsConfig config)
        {
            if (config.Delimiter == "custom" && !string.IsNullOrEmpty(config.CustomSeparator))
            {
                return config.CustomSeparator;
            }
            return config.Delimiter ?? ",";
        }

        private List<string> GetDefaultColumns()
        {
            return new List<string>
            {
                "DonationIdBarcode",
                "DeviceId",
                "Timestamp",
                "LipemicValue",
                "LipemicGroup",
                "LipemicStatus",
                "OperatorIdBarcode"
            };
        }

        private string GetColumnDisplayName(string columnId)
        {
            return columnId switch
            {
                "DonationIdBarcode" => "Donation ID",
                "DeviceId" => "Device ID",
                "Timestamp" => "Timestamp",
                "LipemicValue" => "Lipemic Value",
                "LipemicGroup" => "Lipemic Group",
                "LipemicStatus" => "Lipemic Status",
                "RefCode" => "Reference Code",
                "OperatorIdBarcode" => "Operator ID",
                "LotNumber" => "Lot Number",
                "MessageType" => "Message Type",
                "IPAddress" => "IP Address",
                "Port" => "Port",
                _ => columnId
            };
        }

        private string GetPropertyValue(DonationsData donation, string propertyName, string dateFormat, string timeFormat)
        {
            try
            {
                return propertyName switch
                {
                    "DonationIdBarcode" => donation.DonationIdBarcode ?? string.Empty,
                    "DeviceId" => donation.DeviceId ?? string.Empty,
                    "Timestamp" => donation.Timestamp.ToString($"{dateFormat ?? "yyyy-MM-dd"} {timeFormat ?? "HH:mm:ss"}"),
                    "LipemicValue" => donation.LipemicValue?.ToString() ?? string.Empty,
                    "LipemicGroup" => donation.LipemicGroup ?? string.Empty,
                    "LipemicStatus" => donation.LipemicStatus ?? string.Empty,
                    "RefCode" => donation.RefCode ?? string.Empty,
                    "OperatorIdBarcode" => donation.OperatorIdBarcode ?? string.Empty,
                    "LotNumber" => donation.LotNumber ?? string.Empty,
                    "MessageType" => donation.MessageType ?? string.Empty,
                    "IPAddress" => donation.IPAddress ?? string.Empty,
                    "Port" => donation.Port.ToString(),
                    _ => string.Empty
                };
            }
            catch
            {
                return string.Empty;
            }
        }
    }
}