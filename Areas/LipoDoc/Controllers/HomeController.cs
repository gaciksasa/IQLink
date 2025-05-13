using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using IQLink.Models;
using IQLink.Services;
using IQLink.Data;
using Microsoft.EntityFrameworkCore;
using IQLink.Areas.LipoDoc.Models;

namespace IQLink.Areas.LipoDoc.Controllers
{
    [Area("LipoDoc")]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly DatabaseStatusService _databaseStatusService;
        private readonly ApplicationLifetimeService _applicationLifetimeService;
        private readonly LipoDocDbContext _context;

        public HomeController(
            ILogger<HomeController> logger,
            DatabaseStatusService databaseStatusService,
            ApplicationLifetimeService applicationLifetimeService,
            LipoDocDbContext context)
        {
            _logger = logger;
            _databaseStatusService = databaseStatusService;
            _applicationLifetimeService = applicationLifetimeService;
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var model = new DashboardViewModel();

            // Check database connection status
            var (isConnected, statusMessage) = await _databaseStatusService.CheckDatabaseConnectionAsync();
            model.DatabaseConnected = isConnected;
            model.DatabaseStatus = statusMessage;
            model.SystemUptime = _applicationLifetimeService.GetUptime();

            // Only fetch metrics if database is connected
            if (isConnected)
            {
                try
                {
                    // Get counts for dashboard
                    model.DonationsCount = await _context.DonationsData.CountAsync();
                    model.DevicesCount = await _context.Devices.CountAsync();
                    model.ActiveDevicesCount = await _context.Devices.CountAsync(d => d.IsActive);

                    // Get recent activities
                    model.RecentDonations = await _context.DonationsData
                        .OrderByDescending(d => d.Timestamp)
                        .Take(5)
                        .ToListAsync();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error fetching dashboard metrics");
                }
            }

            return View(model);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}