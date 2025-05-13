using IQLink.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace IQLink.Services
{
    public class DbContextFactory
    {
        private readonly IServiceScopeFactory _scopeFactory;

        public DbContextFactory(IServiceScopeFactory scopeFactory)
        {
            _scopeFactory = scopeFactory;
        }

        public CoreDbContext CreateCoreContext()
        {
            var scope = _scopeFactory.CreateScope();
            return scope.ServiceProvider.GetRequiredService<CoreDbContext>();
        }

        public LipoDocDbContext CreateLipoDocContext()
        {
            var scope = _scopeFactory.CreateScope();
            return scope.ServiceProvider.GetRequiredService<LipoDocDbContext>();
        }

        // Add methods for other device contexts as needed

        // Generic method to get the appropriate context
        public TContext GetDeviceContext<TContext>(string deviceType) where TContext : DbContext
        {
            var scope = _scopeFactory.CreateScope();

            return deviceType.ToLower() switch
            {
                "lipodoc" => (TContext)scope.ServiceProvider.GetRequiredService<LipoDocDbContext>(),
                // Add other device types here
                _ => (TContext)scope.ServiceProvider.GetRequiredService<CoreDbContext>()
            };
        }
    }
}