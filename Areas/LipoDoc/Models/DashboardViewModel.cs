using IQLink.Models;

namespace IQLink.Areas.LipoDoc.Models
{
    public class DashboardViewModel
    {
        public int DevicesCount { get; set; }
        public int ActiveDevicesCount { get; set; }
        public int DonationsCount { get; set; }
        public TimeSpan SystemUptime { get; set; }
        public List<DonationsData> RecentDonations { get; set; } = new List<DonationsData>();
        public bool DatabaseConnected { get; set; }
        public string DatabaseStatus { get; set; }
    }
}