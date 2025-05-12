using DeviceDataCollector.Models;
using Microsoft.EntityFrameworkCore;

namespace DeviceDataCollector.Data
{
    public class CoreDbContext : DbContext
    {
        public CoreDbContext(DbContextOptions<CoreDbContext> options) : base(options)
        {
        }

        // System-wide data
        public DbSet<User> Users { get; set; }
        public DbSet<SystemNotification> SystemNotifications { get; set; }
        public DbSet<DeviceModuleInfo> DeviceModules { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Seed admin and user accounts
            modelBuilder.Entity<User>().HasData(
                new User
                {
                    Id = 1,
                    Username = "admin",
                    // Pre-hashed password for "admin123" 
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("admin123"),
                    Role = "Admin",
                    FullName = "Administrator",
                    Email = "admin@blooddonation.org",
                    CreatedAt = DateTime.Now
                },
                new User
                {
                    Id = 2,
                    Username = "user",
                    // Pre-hashed password for "user123"
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("user123"),
                    Role = "User",
                    FullName = "Regular User",
                    Email = "user@blooddonation.org",
                    CreatedAt = DateTime.Now
                }
            );
        }
    }
}