namespace DeviceDataCollector.Models
{
    public class DeviceModuleInfo
    {
        public string Id { get; set; }
        public string DisplayName { get; set; }
        public string Description { get; set; }
        public string Version { get; set; }
        public string EntryUrl { get; set; }
        public string IconClass { get; set; }
        public bool IsEnabled { get; set; }
    }
}