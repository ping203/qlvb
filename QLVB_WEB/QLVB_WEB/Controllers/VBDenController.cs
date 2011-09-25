using System;
using System.Globalization;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using QLVB_WEB.Models;
using System.Security.Cryptography;
using Ext.Net;
using Ext.Net.MVC;
using System.Linq;

namespace QLVB_WEB.Controllers
{
    public class VBDenController : BaseController
    {
        //
        // GET: /VBDen/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult TiepnhanXuly()
        {
            //string sMaChucvu = "";
            //var query = (from c in DBContext.DMNHANVIENs.Where(c => c.USERNAME.ToLower() == this.HttpContext.User.Identity.Name.ToLower())
            //             select c).Take(1);
            //foreach (DMNHANVIEN usr in query)
            //{
            //    this.ViewData["Admin"] = usr.ADMIN;
            //    this.ViewData["Username"] = usr.TEN;
            //    sMaChucvu = usr.CHUCVU;
            //}

            //var qrChucvu = from c in DBContext.DMCHUCVUs.Where(c => c.MACHUCVU == sMaChucvu)
            //               select c;
            //foreach (DMCHUCVU cv in qrChucvu)
            //{
            //    this.ViewData["Chucvu"] = cv.TENCHUCVU;
            //    this.ViewData["MaChucvu"] = cv.MACHUCVU;
            //    this.ViewData["MaChucnang"] = cv.MACHUCNANG;
            //    break;
            //}

            return View();
        }

        protected int MyFunc(string sIDVB)
        {
            return 1;
        }

        public AjaxStoreResult VBDenList(int start, int limit)
        {
            string sMaChucvu = "";
            string sMaChucnang = "";
            
            var query = from c in DBContext.DMNHANVIENs.Where(c => c.USERNAME.ToLower() == this.HttpContext.User.Identity.Name.ToLower())
                         select c;
            foreach (DMNHANVIEN usr in query)
            {
                sMaChucvu = usr.CHUCVU;
                break;
            }

            var qrChucvu = from c in DBContext.DMCHUCVUs.Where(c => c.MACHUCVU == sMaChucvu)
                           select c;
            foreach (DMCHUCVU cv in qrChucvu)
            {
                sMaChucnang = cv.MACHUCNANG;
                break;
            }

            var qrXulyVB = from xl in DBContext.DEN_XULYVB
                           group xl by xl.IDVB into g
                           select new { IDVB=g.Key, CACHTHUC=(int?)g.Max(xl=>xl.CACHTHUC) ?? -1};
                           

            var qrVB = from vb in DBContext.DEN_VANBAN
                       join att in DBContext.DEN_DINHKEM on vb.IDVB equals att.IDVB into attCounts
                       join xl in qrXulyVB on vb.IDVB equals xl.IDVB into xlVB
                       from a in xlVB.DefaultIfEmpty()
                       select new
                       {
                           IDVB = vb.IDVB,
                           NOIGUI = vb.NOIGUI,
                           TENSOVB = vb.TENSOVB,
                           SODEN = vb.SODEN,
                           NGAYDEN = vb.NGAYDEN,
                           KYHIEU = vb.KYHIEU,
                           NGAYVANBAN = vb.NGAYVANBAN,
                           LOAIVANBAN = vb.LOAIVANBAN,
                           TRICHYEU = vb.TRICHYEU,
                           MAHOSO = vb.MAHOSO,
                           DOMAT = vb.DOMAT,
                           DOKHAN = vb.DOKHAN,
                           SOTO = vb.SOTO,
                           THOIHAN = vb.THOIHAN,
                           NGUOIKY = vb.NGUOIKY,
                           CHUCVUNGUOIKY = vb.CHUCVUNGUOIKY,
                           CANXULY = vb.CANXULY,
                           ATTACH = attCounts.Count(),
                           STATE = (int?)a.CACHTHUC ?? -1
                       };

            var qrAtt = from vb in qrVB
                        from att in DBContext.DEN_DINHKEM.Where(att => att.IDVB == vb.IDVB)
                        select att;

            int nCount = qrVB.Count();
            return new AjaxStoreResult(qrVB.OrderBy(vb => vb.NGAYDEN).Skip(start).Take(limit), nCount);
        }
    }

    
}
