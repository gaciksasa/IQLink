using IQLink.Data;
using IQLink.Services;
using IQLink.Middleware;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Add authentication
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.ExpireTimeSpan = TimeSpan.FromHours(8);
        options.SlidingExpiration = true;
        options.LoginPath = "/Account/Login";
        options.LogoutPath = "/Account/Logout";
        options.AccessDeniedPath = "/Account/AccessDenied";
    });

// Add authorization policies
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("RequireAdminRole", policy => policy.RequireRole("Admin"));
    options.AddPolicy("RequireUserRole", policy => policy.RequireRole("User", "Admin"));
});

// Add multiple database contexts
// Core database context
builder.Services.AddDbContext<CoreDbContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("CoreConnection") ??
        builder.Configuration.GetConnectionString("DefaultConnection"),
        ServerVersion.AutoDetect(
            builder.Configuration.GetConnectionString("CoreConnection") ??
            builder.Configuration.GetConnectionString("DefaultConnection"))
    )
);

// LipoDoc database context
builder.Services.AddDbContext<LipoDocDbContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("LipoDocConnection") ??
        builder.Configuration.GetConnectionString("DefaultConnection"),
        ServerVersion.AutoDetect(
            builder.Configuration.GetConnectionString("LipoDocConnection") ??
            builder.Configuration.GetConnectionString("DefaultConnection"))
    )
);

// Legacy ApplicationDbContext (to be phased out)
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        ServerVersion.AutoDetect(builder.Configuration.GetConnectionString("DefaultConnection"))
    )
);

// Register new hub-architecture services
builder.Services.AddSingleton<DbContextFactory>();
builder.Services.AddSingleton<DeviceModuleRegistry>();

// Register existing services
builder.Services.AddSingleton<TCPServerService>();
builder.Services.AddHostedService(provider => provider.GetRequiredService<TCPServerService>());
builder.Services.AddSingleton<DeviceStatusMonitorService>();
builder.Services.AddHostedService(provider => provider.GetRequiredService<DeviceStatusMonitorService>());
builder.Services.AddSingleton<DeviceStatusCleanupService>();
builder.Services.AddHostedService(provider => provider.GetRequiredService<DeviceStatusCleanupService>());
builder.Services.AddScoped<DatabaseStatusService>();
builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<DeviceMessageParser>();
builder.Services.AddScoped<BCrypt.Net.BCrypt>();
builder.Services.AddSingleton<IViewContextAccessor, ViewContextAccessor>();
builder.Services.AddScoped<NetworkUtilityService>();
builder.Services.AddScoped<DatabaseConfigService>();
builder.Services.AddScoped<DatabaseBackupService>(provider =>
    new DatabaseBackupService(
        provider.GetRequiredService<ILogger<DatabaseBackupService>>(),
        provider.GetRequiredService<IConfiguration>(),
        provider.GetRequiredService<IWebHostEnvironment>()));
builder.Services.AddSingleton<ScheduledBackupService>();
builder.Services.AddHostedService(provider => provider.GetRequiredService<ScheduledBackupService>());
builder.Services.AddSingleton<ApplicationLifetimeService>();
builder.Services.AddScoped<DeviceCommunicationService>();
builder.Services.AddHostedService<AutoExportService>();
builder.Services.AddScoped<DonationExportHelper>();

var app = builder.Build();

// Initialize database 
try
{
    using (var scope = app.Services.CreateScope())
    {
        var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();

        // Initialize Core database
        logger.LogInformation("Initializing Core database...");
        await InitializeDatabase<CoreDbContext>(scope, logger, "Core");

        // Initialize LipoDoc database
        logger.LogInformation("Initializing LipoDoc database...");
        await InitializeDatabase<LipoDocDbContext>(scope, logger, "LipoDoc");

        // Initialize legacy database for backward compatibility
        logger.LogInformation("Initializing legacy database...");
        var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();

        // Check if database exists and can connect
        bool canConnect = await dbContext.Database.CanConnectAsync();
        if (!canConnect)
        {
            logger.LogWarning("Legacy database connection failed. Will attempt to create database.");
            // This will create the database if it doesn't exist
            await dbContext.Database.EnsureCreatedAsync();
            logger.LogInformation("Legacy database created successfully.");
        }

        // Explicitly check if CurrentDeviceStatuses table exists by attempting a query
        bool currentDeviceStatusTableExists = false;
        try
        {
            // Try to query the table (this will throw an exception if it doesn't exist)
            await dbContext.CurrentDeviceStatuses.FirstOrDefaultAsync();
            currentDeviceStatusTableExists = true;
        }
        catch (Exception)
        {
            logger.LogWarning("CurrentDeviceStatuses table does not exist. It will be created.");
        }

        if (!currentDeviceStatusTableExists)
        {
            try
            {
                // Create the table manually using SQL
                var createTableSql = @"
                CREATE TABLE IF NOT EXISTS `CurrentDeviceStatuses` (
                    `DeviceId` varchar(255) NOT NULL,
                    `Timestamp` datetime(6) NOT NULL,
                    `Status` int NOT NULL,
                    `AvailableData` int NOT NULL,
                    `IPAddress` longtext NULL,
                    `Port` int NOT NULL,
                    `CheckSum` longtext NULL,
                    `StatusUpdateCount` int NOT NULL DEFAULT 0,
                    PRIMARY KEY (`DeviceId`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

                await dbContext.Database.ExecuteSqlRawAsync(createTableSql);
                logger.LogInformation("CurrentDeviceStatuses table created successfully.");
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error creating CurrentDeviceStatuses table.");
            }
        }

        // Apply any pending migrations for other tables
        try
        {
            if ((await dbContext.Database.GetPendingMigrationsAsync()).Any())
            {
                logger.LogInformation("Applying pending migrations to legacy database...");
                await dbContext.Database.MigrateAsync();
                logger.LogInformation("Migrations applied successfully to legacy database.");
            }
            else
            {
                logger.LogInformation("Legacy database is up to date. No migrations needed.");
            }
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error applying migrations to legacy database.");
        }

        logger.LogInformation("Database initialization completed");
    }
}
catch (Exception ex)
{
    var logger = app.Services.GetRequiredService<ILogger<Program>>();
    logger.LogError(ex, "An error occurred while initializing databases. Application will continue, but database features may not work.");
}

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();
app.UseAuthenticationRedirect();

// Add area routing configuration
app.MapAreaControllerRoute(
    name: "LipoDoc",
    areaName: "LipoDoc",
    pattern: "LipoDoc/{controller=Home}/{action=Index}/{id?}");

// Add main areas route
app.MapControllerRoute(
    name: "areas",
    pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}");

// Default route
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();

// Helper method for database initialization
async Task InitializeDatabase<TContext>(IServiceScope scope, ILogger logger, string dbName) where TContext : DbContext
{
    try
    {
        var context = scope.ServiceProvider.GetRequiredService<TContext>();

        logger.LogInformation($"Checking {dbName} database connection...");
        bool canConnect = await context.Database.CanConnectAsync();

        if (!canConnect)
        {
            logger.LogWarning($"{dbName} database connection failed. Will attempt to create database.");
            await context.Database.EnsureCreatedAsync();
            logger.LogInformation($"{dbName} database created successfully.");
        }

        try
        {
            if ((await context.Database.GetPendingMigrationsAsync()).Any())
            {
                logger.LogInformation($"Applying pending migrations to {dbName} database...");
                await context.Database.MigrateAsync();
                logger.LogInformation($"Migrations applied successfully to {dbName} database.");
            }
            else
            {
                logger.LogInformation($"{dbName} database is up to date. No migrations needed.");
            }
        }
        catch (Exception ex)
        {
            logger.LogError(ex, $"Error applying migrations to {dbName} database.");
        }
    }
    catch (Exception ex)
    {
        logger.LogError(ex, $"Error initializing {dbName} database.");
    }
}