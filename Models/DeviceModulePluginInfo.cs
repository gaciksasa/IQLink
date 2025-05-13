namespace DeviceDataCollector.Models
{
    public class DeviceModulePluginInfo
    {
        public string Id { get; set; }
        public string DisplayName { get; set; }
        public string Description { get; set; }
        public string Version { get; set; }
        public string AreaName { get; set; }
        public string AssemblyName { get; set; }
        public bool IsEnabled { get; set; }
    }
}