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
    public abstract class BaseController : Controller
    {
        QLVBEntities _db;

        public QLVBEntities DBContext
        {
            get { return this._db; }
        }

        public BaseController()
        {
            string connectionString = "";
            System.Configuration.Configuration rootWebConfig =
                System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/");
            try
            {
                if (rootWebConfig.ConnectionStrings.ConnectionStrings.Count > 0)
                {
                    connectionString = rootWebConfig.ConnectionStrings.ConnectionStrings["QLVBEntities"].ConnectionString;
                }
            }
            catch
            {
            }
            
            _db = new QLVBEntities(connectionString);
        }

        protected int GetNewNhanvienID()
        {
            QLVBEntities db = this.DBContext;
            if (db.Connection.State == System.Data.ConnectionState.Closed)
                db.Connection.Open();


            ObjectResult<int?> n = db.GetNewSeqVal("Nhanvien_seq");

            foreach (int i in n)
            {
                return i;
            }

            return 0;
        }
    }
}
