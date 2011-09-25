using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace QLVB_WEB
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new RemoteRequireHttpsAttribute());
        }

        protected void Application_AuthenticateRequest(object sender, System.EventArgs e)
        {
            string url = HttpContext.Current.Request.RawUrl.ToLower();
            if (url.Contains("ext.axd") || url.Contains("account/login"))
            {
                HttpContext.Current.SkipAuthorization = true;
                if (url.Contains("returnurl=/") || url.Contains("returnurl=%2f"))
                {
                    Response.Redirect(url.Replace("returnurl=/", "r=/").Replace("returnurl=%2f", "r=/"));
                }
            }
            else if (url.Contains("returnurl=/default.aspx") || url.Contains("returnurl=%2fdefault.aspx"))
            {
                Response.Redirect(url.Replace("returnurl=/default.aspx", "r=/").Replace("returnurl=%2fdefault.aspx", "r=/"));
            }
           
        } 

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{exclude}/{extnet}/ext.axd");

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }

        void Session_Start(object sender, EventArgs e)
        {
            if (Response.Cookies.Count > 0)
            {
                foreach (string s in Response.Cookies.AllKeys)
                {
                    if (s == System.Web.Security.FormsAuthentication.FormsCookieName || s.ToLower() == "asp.net_sessionid")
                    {
                        Response.Cookies[s].HttpOnly = false;
                    }
                }
            }
        }
    }

    public partial class RemoteRequireHttpsAttribute : RequireHttpsAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (filterContext == null)
            {
                throw new ArgumentException("Filter Context");
            }

            if (filterContext != null && filterContext.HttpContext != null)
            {
                if (filterContext.HttpContext.Request.IsLocal)
                {
                    return;
                }
                else
                {
                    string ActionName = filterContext.ActionDescriptor.ActionName.ToLower();
                    string ControllerName = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName.ToLower();

                    if (ControllerName == "account" && ActionName == "login")
                    {
                        base.OnAuthorization(filterContext);
                        return;
                    }
                    else if (1 == 0) // Enable HTTPS for all app
                    {
                        base.OnAuthorization(filterContext);
                        return;
                    }
                    else
                    {
                        // non secure requested
                        if (filterContext.HttpContext.Request.IsSecureConnection)
                        {
                            if (String.Equals(filterContext.HttpContext.Request.HttpMethod, "GET", StringComparison.OrdinalIgnoreCase))
                            {
                                // redirect to HTTP version of page
                                string url = "http://" + filterContext.HttpContext.Request.Url.Host + filterContext.HttpContext.Request.RawUrl;
                                filterContext.Result = new RedirectResult(url);
                            }
                        }
                        /////////////////
                        return;
                    }

                }

            }

        }

    }
}