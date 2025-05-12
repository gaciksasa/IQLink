using Microsoft.EntityFrameworkCore;

namespace DeviceDataCollector.Data
{
    public abstract class BaseDeviceDbContext : DbContext
    {
        protected BaseDeviceDbContext(DbContextOptions options) : base(options)
        {
        }

        // Common configuration and methods can go here
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            // Add any shared model configuration here
        }
    }
}