using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace IQLink.Filters
{
    public class ViewContextFilter : IActionFilter
    {
        public void OnActionExecuting(ActionExecutingContext context)
        {
            // Nothing to do here
        }

        public void OnActionExecuted(ActionExecutedContext context)
        {
            if (context.Result is ViewResult viewResult)
            {
                // ViewContext is available in view, so no need to do anything here
            }
        }
    }
}