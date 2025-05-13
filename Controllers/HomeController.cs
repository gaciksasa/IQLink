// Controllers/HomeController.cs (root area, not LipoDoc area)
using Microsoft.AspNetCore.Mvc;
using IQLink.Services;
using IQLink.Models;
using System.Diagnostics;

namespace IQLink.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly DeviceModuleRegistry _deviceModuleRegistry;
        private readonly DatabaseStatusService _databaseStatusService;

        public HomeController(
            ILogger<HomeController> logger,
            DeviceModuleRegistry deviceModuleRegistry,
            DatabaseStatusService databaseStatusService)
        {
            _logger = logger;
            _deviceModuleRegistry = deviceModuleRegistry;
            _databaseStatusService = databaseStatusService;
        }

        public async Task<IActionResult> Index()
        {
            // Get available device modules
            var availableModules = _deviceModuleRegistry.GetAvailableModules();

            // Check database connection status
            var (isConnected, statusMessage) = await _databaseStatusService.CheckDatabaseConnectionAsync();
            ViewBag.DatabaseConnected = isConnected;
            ViewBag.DatabaseStatus = statusMessage;

            return View(availableModules);
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