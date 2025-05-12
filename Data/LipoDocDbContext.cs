using DeviceDataCollector.Models;
using Microsoft.EntityFrameworkCore;

namespace DeviceDataCollector.Data
{
    public class LipoDocDbContext : BaseDeviceDbContext
    {
        public LipoDocDbContext(DbContextOptions<LipoDocDbContext> options) : base(options)
        {
        }

        public DbSet<DonationsData> DonationsData { get; set; }
        public DbSet<DeviceStatus> DeviceStatuses { get; set; }
        public DbSet<CurrentDeviceStatus> CurrentDeviceStatuses { get; set; }
        public DbSet<Device> Devices { get; set; }
        public DbSet<DeviceSetup> DeviceSetups { get; set; }
        public DbSet<ExportSettingsConfig> ExportSettingsConfigs { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // LipoDoc-specific configurations
            modelBuilder.Entity<DonationsData>()
                .HasIndex(d => d.DeviceId);

            modelBuilder.Entity<DonationsData>()
                .HasIndex(d => d.Timestamp);

            modelBuilder.Entity<DonationsData>()
                .HasIndex(d => d.DonationIdBarcode);

            modelBuilder.Entity<DeviceStatus>()
                .HasIndex(d => d.DeviceId);

            modelBuilder.Entity<DeviceStatus>()
                .HasIndex(d => d.Timestamp);
        }
    }
}