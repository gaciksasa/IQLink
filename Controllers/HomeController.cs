using Microsoft.AspNetCore.Mvc;
using IQLink.Models;
using System.Diagnostics;

namespace IQLink.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            // For now, we'll just hardcode the LipoDoc module
            var modules = new List<DeviceModuleInfo>
            {
                new DeviceModuleInfo
                {
                    Id = "lipodoc",
                    DisplayName = "LipoDoc",
                    Description = "Blood donation lipemic monitoring system",
                    Version = "1.0",
                    EntryUrl = "/LipoDoc/Home/Index",
                    IconClass = "bi bi-droplet-fill",
                    IsEnabled = true
                }
            };

            return View(modules);
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