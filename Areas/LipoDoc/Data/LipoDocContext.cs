using DeviceDataCollector.Models;
using Microsoft.EntityFrameworkCore;

namespace DeviceDataCollector.Areas.LipoDoc.Data
{
    public class LipoDocContext : DbContext
    {
        public LipoDocContext(DbContextOptions<LipoDocContext> options) : base(options)
        {
        }

        // Add your DbSet properties here, for example:
        // public DbSet<YourModel> YourModels { get; set; }
    }
}