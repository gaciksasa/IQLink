using IQLink.Models;
using Microsoft.EntityFrameworkCore;

namespace IQLink.Areas.LipoDoc.Data
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