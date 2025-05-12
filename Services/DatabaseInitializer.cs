using DeviceDataCollector.Data;
using Microsoft.EntityFrameworkCore;

namespace DeviceDataCollector.Services
{
    public static class DatabaseInitializer
    {
        public static async Task InitializeAllDatabasesAsync(IServiceProvider serviceProvider, ILogger logger)
        {
            try
            {
                using var scope = serviceProvider.CreateScope();

                // Initialize core database
                var coreContext = scope.ServiceProvider.GetRequiredService<CoreDbContext>();
                await InitializeDatabaseAsync(coreContext, "Core", logger);

                // Initialize LipoDoc database if enabled
                var config = scope.ServiceProvider.GetRequiredService<IConfiguration>();
                var enabledDevices = config.GetSection("DatabaseSettings:EnabledDevices").Get<string[]>() ?? Array.Empty<string>();

                if (enabledDevices.Contains("LipoDoc", StringComparer.OrdinalIgnoreCase))
                {
                    var lipoDocContext = scope.ServiceProvider.GetRequiredService<LipoDocDbContext>();
                    await InitializeDatabaseAsync(lipoDocContext, "LipoDoc", logger);
                }

                // Initialize other device databases as needed
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "An error occurred while initializing databases");
                throw; // Re-throw to halt startup if database initialization fails
            }
        }

        private static async Task InitializeDatabaseAsync(DbContext dbContext, string contextName, ILogger logger)
        {
            try
            {
                logger.LogInformation($"Checking {contextName} database existence and applying migrations if needed...");

                // This will create the database if it doesn't exist and apply any pending migrations
                await dbContext.Database.MigrateAsync();

                logger.LogInformation($"{contextName} database check complete - database is ready");
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"An error occurred while initializing the {contextName} database");
                throw;
            }
        }
    }
}