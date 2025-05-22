using IQLink.Data;
using IQLink.Models;
using Microsoft.EntityFrameworkCore;

namespace IQLink.Services
{
    /// <summary>
    /// Background service to handle automatic export of donation records
    /// </summary>
    public class AutoExportService : BackgroundService
    {
        private readonly ILogger<AutoExportService> _logger;
        private readonly IServiceScopeFactory _scopeFactory;
        private readonly HashSet<int> _processedDonationIds = new HashSet<int>();
        private DateTime _lastExportCheck = DateTime.MinValue;
        private readonly object _lockObject = new object();

        public AutoExportService(
            ILogger<AutoExportService> logger,
            IServiceScopeFactory scopeFactory)
        {
            _logger = logger;
            _scopeFactory = scopeFactory;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Auto Export Service is starting...");

            try
            {
                // Wait for 30 seconds after startup to allow the application to fully initialize
                await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);

                // Initialize last check time to prevent exporting all existing records on startup
                _lastExportCheck = DateTime.Now.AddMinutes(-5); // Only check records from last 5 minutes on startup

                while (!stoppingToken.IsCancellationRequested)
                {
                    try
                    {
                        // Check for new donations every 15 seconds
                        await CheckForNewDonations(stoppingToken);

                        // Clean up processed IDs cache periodically
                        CleanupProcessedIds();

                        // Wait before next check
                        await Task.Delay(TimeSpan.FromSeconds(15), stoppingToken);
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError(ex, "Error checking for new donations");
                        // Wait a bit longer before next check in case of errors
                        await Task.Delay(TimeSpan.FromSeconds(60), stoppingToken);
                    }
                }
            }
            catch (OperationCanceledException)
            {
                // This is expected when stopping
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in Auto Export Service");
            }
            finally
            {
                _logger.LogInformation("Auto Export Service is stopping...");
            }
        }

        private async Task CheckForNewDonations(CancellationToken stoppingToken)
        {
            try
            {
                using var scope = _scopeFactory.CreateScope();
                var dbContext = scope.ServiceProvider.GetRequiredService<LipoDocDbContext>();

                // Check if auto-export is enabled by checking if there are any enabled configurations
                var hasEnabledConfigs = await dbContext.ExportSettingsConfigs
                    .AnyAsync(c => c.AutoExportEnabled, stoppingToken);

                if (!hasEnabledConfigs)
                {
                    // No auto-export configurations enabled - only log every 5 minutes to avoid spam
                    if (DateTime.Now.Subtract(_lastExportCheck).TotalMinutes > 5)
                    {
                        _logger.LogDebug("No auto-export configurations enabled, skipping export check");
                        _lastExportCheck = DateTime.Now;
                    }
                    return;
                }

                // Get new donations since last check
                var currentCheckTime = DateTime.Now;
                var query = dbContext.DonationsData
                    .Where(d => d.Timestamp > _lastExportCheck && d.MessageType == "#D") // Only data messages
                    .AsQueryable();

                // Skip donations we've already processed
                lock (_lockObject)
                {
                    if (_processedDonationIds.Any())
                    {
                        query = query.Where(d => !_processedDonationIds.Contains(d.Id));
                    }
                }

                // Get the donations ordered by timestamp (oldest first)
                var newDonations = await query
                    .OrderBy(d => d.Timestamp)
                    .ToListAsync(stoppingToken);

                if (newDonations.Any())
                {
                    _logger.LogInformation("Found {Count} new donations to auto-export", newDonations.Count);

                    try
                    {
                        var exportHelper = scope.ServiceProvider.GetRequiredService<DonationExportHelper>();

                        // Get all enabled auto-export configurations
                        var configs = await dbContext.ExportSettingsConfigs
                            .Where(c => c.AutoExportEnabled)
                            .OrderByDescending(c => c.IsDefault)
                            .ThenByDescending(c => c.LastUsedAt)
                            .ToListAsync(stoppingToken);

                        if (configs.Any())
                        {
                            // Use the first (default or most recently used) configuration for auto-export
                            var defaultConfig = configs.First();
                            _logger.LogInformation("Auto-exporting {Count} donations using config '{ConfigName}'",
                                newDonations.Count, defaultConfig.Name);

                            await exportHelper.ExportDonations(newDonations, defaultConfig);

                            // Mark all as processed
                            lock (_lockObject)
                            {
                                foreach (var donation in newDonations)
                                {
                                    _processedDonationIds.Add(donation.Id);
                                }
                            }

                            _logger.LogInformation("Successfully auto-exported {Count} donations", newDonations.Count);
                        }
                        else
                        {
                            _logger.LogWarning("No enabled auto-export configurations found, but hasEnabledConfigs was true");
                        }
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError(ex, "Error during auto-export of {Count} donations", newDonations.Count);

                        // Still mark as processed to avoid repeated export attempts
                        lock (_lockObject)
                        {
                            foreach (var donation in newDonations)
                            {
                                _processedDonationIds.Add(donation.Id);
                            }
                        }
                    }
                }
                else
                {
                    _logger.LogDebug("No new donations found for auto-export");
                }

                // Update last check time
                _lastExportCheck = currentCheckTime;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking for new donations");
            }
        }

        private void CleanupProcessedIds()
        {
            lock (_lockObject)
            {
                // Limit the size of the processed set to prevent memory growth
                if (_processedDonationIds.Count > 2000)
                {
                    _logger.LogInformation("Cleaning up processed donation IDs cache (size: {Count})", _processedDonationIds.Count);

                    // Keep only the most recent 1000 IDs (this is a simple approach)
                    var idsToKeep = _processedDonationIds.OrderByDescending(id => id).Take(1000).ToHashSet();
                    _processedDonationIds.Clear();
                    foreach (var id in idsToKeep)
                    {
                        _processedDonationIds.Add(id);
                    }

                    _logger.LogInformation("Processed donation IDs cache cleaned up, now contains {Count} IDs", _processedDonationIds.Count);
                }
            }
        }

        public override async Task StopAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Auto Export Service stop requested");
            await base.StopAsync(stoppingToken);
        }
    }
}