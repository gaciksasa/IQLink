using IQLink.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace IQLink.Areas.LipoDoc.Controllers
{
    /// <summary>
    /// Base controller for all LipoDoc controllers
    /// Provides common functionality and database context access
    /// </summary>
    [Area("LipoDoc")]
    [Authorize]
    public abstract class LipoDocBaseController : Controller
    {
        protected readonly ILogger _logger;

        /// <summary>
        /// Constructor with dependency injection for database context and logger
        /// </summary>
        /// <param name="context">The LipoDoc database context</param>
        /// <param name="logger">Logger instance</param>
        protected LipoDocBaseController(ILogger logger)
        {
            _logger = logger;
        }

        /// <summary>
        /// Helper method to check if current user is in admin role
        /// </summary>
        protected bool IsAdmin()
        {
            return User.IsInRole("Admin");
        }

        /// <summary>
        /// Helper method to get the current username
        /// </summary>
        protected string GetCurrentUsername()
        {
            return User.Identity?.Name ?? "Unknown";
        }

        /// <summary>
        /// Handle common errors and return appropriate view
        /// </summary>
        protected IActionResult HandleError(Exception ex, string entityName, string action)
        {
            _logger.LogError(ex, $"Error {action} {entityName}");

            TempData["ErrorMessage"] = $"An error occurred while {action} the {entityName}. {ex.Message}";

            // If the error is related to a not found entity, return a NotFound result
            if (ex.Message.Contains("not found", StringComparison.OrdinalIgnoreCase) ||
                ex.Message.Contains("does not exist", StringComparison.OrdinalIgnoreCase))
            {
                return NotFound();
            }

            // For concurrency exceptions, show a specific message
            if (ex is DbUpdateConcurrencyException)
            {
                TempData["ErrorMessage"] = $"The {entityName} has been modified by another user. Please refresh and try again.";
            }

            // For other database exceptions, provide a generic message
            if (ex is DbUpdateException)
            {
                TempData["ErrorMessage"] = $"Database error while {action} the {entityName}. Please try again.";
            }

            return RedirectToAction("Index");
        }
    }
}