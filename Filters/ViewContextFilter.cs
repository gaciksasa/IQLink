using Microsoft.AspNetCore.Mvc.Filters;
using IQLink.Services;
using Microsoft.AspNetCore.Mvc;

namespace IQLink.Filters
{
    public class ViewContextFilter : IActionFilter
    {
        private readonly IViewContextAccessor _viewContextAccessor;

        public ViewContextFilter(IViewContextAccessor viewContextAccessor)
        {
            _viewContextAccessor = viewContextAccessor;
        }

        public void OnActionExecuting(ActionExecutingContext context)
        {
        }

        public void OnActionExecuted(ActionExecutedContext context)
        {
            if (context.Controller is Controller controller)
            {
                _viewContextAccessor.ViewContext = controller.ViewContext;
            }
        }
    }
}