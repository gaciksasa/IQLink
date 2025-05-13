using IQLink.Models;

namespace IQLink.Services
{
    public class DeviceModuleRegistry
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<DeviceModuleRegistry> _logger;
        private readonly List<DeviceModuleInfo> _modules = new List<DeviceModuleInfo>();

        public DeviceModuleRegistry(IConfiguration configuration, ILogger<DeviceModuleRegistry> logger)
        {
            _configuration = configuration;
            _logger = logger;
            InitializeModules();
        }

        private void InitializeModules()
        {
            try
            {
                // Add built-in modules
                _modules.Add(new DeviceModuleInfo
                {
                    Id = "lipodoc",
                    DisplayName = "LipoDoc",
                    Description = "Manage LipoDoc devices for lipemic sample testing",
                    Version = "1.0",
                    EntryUrl = "/LipoDoc/Home/Index",
                    IconClass = "bi bi-droplet-fill",
                    IsEnabled = true
                });

                // In the future, add more modules here or load them from configuration

                // Check against enabled modules in configuration
                var enabledDevices = _configuration.GetSection("DatabaseSettings:EnabledDevices").Get<string[]>() ?? Array.Empty<string>();
                foreach (var module in _modules)
                {
                    module.IsEnabled = enabledDevices.Contains(module.Id, StringComparer.OrdinalIgnoreCase);
                }

                _logger.LogInformation($"Initialized {_modules.Count} device modules, {_modules.Count(m => m.IsEnabled)} enabled");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error initializing device modules");
            }
        }

        public IEnumerable<DeviceModuleInfo> GetAvailableModules()
        {
            return _modules.Where(m => m.IsEnabled).ToList();
        }

        public DeviceModuleInfo GetModule(string id)
        {
            return _modules.FirstOrDefault(m => m.Id.Equals(id, StringComparison.OrdinalIgnoreCase));
        }
    }
}