using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Data.Objects;
using System.Web;
using System.Web.Mvc;
using QLVB_WEB.Models;
using Ext.Net;
using Ext.Net.MVC;

namespace QLVB_WEB.Controllers
{
    [HandleError]
    [Authorize]
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            string sMaChucvu = "";
            this.ViewData["AppName"] = "<font style=\"font-family: 'Times New Roman', Times, serif; font-size: large; font-weight: bold; color: #15428B;\">QUẢN LÝ CÔNG VĂN</font>";
            //this.ViewData["Username"] = this.HttpContext.User.Identity.Name;

            var query = (from c in DBContext.DMNHANVIENs.Where(c => c.USERNAME.ToLower() == this.HttpContext.User.Identity.Name.ToLower())
                        select c).Take(1);
            foreach(DMNHANVIEN usr in query)
            {
                this.ViewData["Admin"] = usr.ADMIN;
                this.ViewData["Username"] = usr.TEN;
                sMaChucvu = usr.CHUCVU;
            }

            var qrChucvu = from c in DBContext.DMCHUCVUs.Where(c => c.MACHUCVU == sMaChucvu)
                            select c;
            foreach (DMCHUCVU cv in qrChucvu)
            {
                this.ViewData["Chucvu"] = cv.TENCHUCVU;
                this.ViewData["MaChucvu"] = cv.MACHUCVU;
                this.ViewData["MaChucnang"] = cv.MACHUCNANG;
                break;
            }

            return this.View();
        }

        public ActionResult Dashboard()
        {
            List<string> items = new List<string>();
            
            items.Add("test");

            this.ViewData["Data"] = items;

            return this.View();
        }

        public ActionResult About()
        {
            return this.View();
        }

        public ActionResult Form()
        {
            return this.View();
        }

        public AjaxFormResult SaveForm(string txtName, string txtEmail, string txtComments)
        {

            AjaxFormResult result = new AjaxFormResult();

            result.Script = X.Msg.Alert("Success", "Bug report sent").ToScript();
            
            return result;
        }
    }
}
