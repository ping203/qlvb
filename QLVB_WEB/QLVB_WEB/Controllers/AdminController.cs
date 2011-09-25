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
    public class AdminController : BaseController
    {
        

        //
        // GET: /Admin/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Chucvu()
        {
            return View();
        }

        public AjaxStoreResult ChucvuList()
        {
            var query = from c in DBContext.DMCHUCVUs
                        select new
                        {
                            MACHUCVU = c.MACHUCVU,
                            TENCHUCVU = c.TENCHUCVU,
                            MACHUCNANG = c.MACHUCNANG
                        };
            int nCount = query.ToList().Count;
            return new AjaxStoreResult(query, nCount);
        }

        public AjaxStoreResult ChucnangList()
        {
            var query = from c in DBContext.DMCHUCNANGs
                        select new
                        {
                            MACHUCNANG = c.MACHUCNANG,
                            TENCHUCNANG = c.TENCHUCNANG
                        };
            int nCount = query.ToList().Count;
            return new AjaxStoreResult(query, nCount);
        }

        [HttpPost]
        public ActionResult ChucvuList_Save()
        {
            AjaxStoreResult ajaxStoreResult = new AjaxStoreResult(StoreResponseFormat.Save);

            try
            {
                QLVBEntities db = this.DBContext;
                StoreDataHandler dataHandler = new StoreDataHandler(HttpContext.Request["data"]);
                ChangeRecords<DMCHUCVU> data = dataHandler.ObjectData<DMCHUCVU>();
                ConfirmationList confirmationList = dataHandler.BuildConfirmationList("MACHUCVU");

                foreach (DMCHUCVU c in data.Deleted)
                {
                    db.DMCHUCVUs.Attach(c);
                    db.DMCHUCVUs.DeleteObject(c);
                }

                foreach (DMCHUCVU c in data.Created)
                {
                    db.DMCHUCVUs.AddObject(c);
                }

                foreach (DMCHUCVU c in data.Updated)
                {
                    var orgRecord = db.DMCHUCVUs.Single(p => p.MACHUCVU == c.MACHUCVU);
                    db.DMCHUCVUs.ApplyCurrentValues(c);
                }

                db.SaveChanges();

            }
            catch (Exception e)
            {
                ajaxStoreResult.SaveResponse.Success = false;
                int nCode = System.Runtime.InteropServices.Marshal.GetHRForException(e);

                if (nCode == -2146233087)
                    ajaxStoreResult.SaveResponse.Message = "Trùng mã chức năng.";
                else
                    ajaxStoreResult.SaveResponse.Message = e.InnerException.Message;
            }

            return ajaxStoreResult;
        }

        public ActionResult Coquan()
        {
            return View();
        }

        public AjaxStoreResult CoquanList()
        {
            var query = from c in DBContext.DMCOQUANs select c;
            int nCount = query.ToList().Count;
            return new AjaxStoreResult(query, nCount);
        }

        [HttpPost]
        public ActionResult CoquanList_Save()
        {
            AjaxStoreResult ajaxStoreResult = new AjaxStoreResult(StoreResponseFormat.Save);

            try
            {
                QLVBEntities db = this.DBContext;
                StoreDataHandler dataHandler = new StoreDataHandler(HttpContext.Request["data"]);
                ChangeRecords<DMCOQUAN> data = dataHandler.ObjectData<DMCOQUAN>();

                foreach (DMCOQUAN c in data.Deleted)
                {
                    db.DMCOQUANs.Attach(c);
                    db.DMCOQUANs.DeleteObject(c);
                }

                foreach (DMCOQUAN c in data.Created)
                {
                    db.DMCOQUANs.AddObject(c);
                }

                foreach (DMCOQUAN c in data.Updated)
                {
                    var orgRecord = db.DMCOQUANs.Single(p => p.MACOQUAN == c.MACOQUAN);
                    db.DMCOQUANs.ApplyCurrentValues(c);
                }

                db.SaveChanges();

            }
            catch (Exception e)
            {
                ajaxStoreResult.SaveResponse.Success = false;
                int nCode = System.Runtime.InteropServices.Marshal.GetHRForException(e);

                if (nCode == -2146233087)
                    ajaxStoreResult.SaveResponse.Message = "Trùng mã cơ quan.";
                else
                    ajaxStoreResult.SaveResponse.Message = e.InnerException.Message;
            }

            return ajaxStoreResult;
        }
        public ActionResult Phongban()
        {
            return View();
        }

        public AjaxStoreResult PhongbanList()
        {
            var query = from c in DBContext.DMPHONGBANs
                        select
                            new { MAPHONG = c.MAPHONG, TENPHONG = c.TENPHONG };
            int nCount = query.ToList().Count;
            return new AjaxStoreResult(query, nCount);
        }

        [HttpPost]
        public ActionResult PhongbanList_Save()
        {
            AjaxStoreResult ajaxStoreResult = new AjaxStoreResult(StoreResponseFormat.Save);

            try
            {
                QLVBEntities db = this.DBContext;
                StoreDataHandler dataHandler = new StoreDataHandler(HttpContext.Request["data"]);
                ChangeRecords<DMPHONGBAN> data = dataHandler.ObjectData<DMPHONGBAN>();

                foreach (DMPHONGBAN c in data.Deleted)
                {
                    db.DMPHONGBANs.Attach(c);
                    db.DMPHONGBANs.DeleteObject(c);
                }

                foreach (DMPHONGBAN c in data.Created)
                {
                    db.DMPHONGBANs.AddObject(c);
                }

                foreach (DMPHONGBAN c in data.Updated)
                {
                    var orgRecord = db.DMPHONGBANs.Single(p => p.MAPHONG == c.MAPHONG);
                    db.DMPHONGBANs.ApplyCurrentValues(c);
                }

                db.SaveChanges();

            }
            catch (Exception e)
            {
                ajaxStoreResult.SaveResponse.Success = false;
                int nCode = System.Runtime.InteropServices.Marshal.GetHRForException(e);

                if (nCode == -2146233087)
                    ajaxStoreResult.SaveResponse.Message = "Trùng mã phòng ban.";
                else
                    ajaxStoreResult.SaveResponse.Message = e.InnerException.Message;
            }

            return ajaxStoreResult;
        }
        public ActionResult Nhanvien()
        {
            return View();
        }

        public ActionResult Thamso()
        {
            return View();
        }

        private QUYTRINH_POSITION GetPosition(string s)
        {
            string id = "";
            int left = 20, top = 20;
            string[] s1 = s.Split(':');

            try
            {
                if (s1.Count() < 2) return new QUYTRINH_POSITION("", 0, 0);
                id = s1[0].Trim();
                string[] s2 = s1[1].Split(',');
                if (s2.Count() < 2) return new QUYTRINH_POSITION("", 0, 0);
                left = int.Parse(s2[0]);
                top = int.Parse(s2[1]);
            } catch (Exception ex)
            {
                ex.Message.ToString();
            }

            return new QUYTRINH_POSITION(id, left, top);
        }

        private QUYTRINH_CONNECTION GetConnection(string s)
        {
            string id1 = "", id2 = "";

            try
            {
                string[] s1 = s.Split('-');
                if (s1.Count() < 2) return new QUYTRINH_CONNECTION("", "");
                id1 = s1[0].Trim();
                id2 = s1[1].Trim();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }

            return new QUYTRINH_CONNECTION(id1, id2);
        }

        private ActionResult GetQuytrinh(string sConfigName)
        {
            var query = (from c in DBContext.DMCHUCVUs
                         select c).Take(20);
            var quytrinh = (from c in DBContext.THAMSOes.Where(c => c.NAME == sConfigName)
                            select c);

            string sPosition = "", sConnection = "";

            List<QUYTRINH_POSITION> listposition = new List<QUYTRINH_POSITION>();
            List<QUYTRINH_CONNECTION> listconnection = new List<QUYTRINH_CONNECTION>();

            foreach (THAMSO q in quytrinh)
            {
                string[] split = { "Connection:", "Position:" };
                string[] s = q.VALUE.ToString().Split(split, StringSplitOptions.RemoveEmptyEntries);
                int nCount = s.Count();
                if (nCount > 0)
                {
                    sPosition = s[0];
                    if (nCount > 1) sConnection = s[1];

                    List<string> lPos = sPosition.Split(';').ToList();
                    List<string> lConn = sConnection.Split(';').ToList();

                    // Get all stored positions
                    foreach (string sOnePos in lPos)
                    {
                        if (sOnePos.Length > 0)
                        {
                            QUYTRINH_POSITION pos = GetPosition(sOnePos);
                            listposition.Add(pos);
                        }
                    }

                    // Get all stored connections
                    foreach (string sOneConn in lConn)
                    {
                        if (sOneConn.Length > 0)
                        {
                            QUYTRINH_CONNECTION conn = GetConnection(sOneConn);
                            if (conn.TargetID.Length > 0 && conn.SourceID.Length > 0)
                                listconnection.Add(conn);
                        }
                    }

                }
                break;
            }

            ViewData["Position"] = listposition;
            ViewData["Connection"] = listconnection;

            return View(query.ToList());
        }

        private bool SaveQuytrinh(string txtConfigValue, string sConfigName)
        {
            try
            {
                var query = (from c in DBContext.THAMSOes.Where(c => c.NAME == sConfigName)
                             select c);

                int nCount = query.Count();
                if (nCount == 0)
                {
                    THAMSO q = new THAMSO();
                    q.NAME = sConfigName;
                    q.VALUE = txtConfigValue;
                    DBContext.THAMSOes.AddObject(q);
                    DBContext.SaveChanges();
                }
                else
                {
                    foreach (THAMSO q in query)
                    {
                        q.VALUE = txtConfigValue;
                    }

                    DBContext.SaveChanges();
                }
            }
            catch (SystemException ex)
            {
                ex.Message.ToString();
                return false;
            }

            return true;
        }

        public ActionResult Quytrinhdi()
        {
            return GetQuytrinh(Configuration.QUY_TRINH_DI);
        }

        [HttpPost]
        public ActionResult Quytrinhdi_Save(string txtConfig)
        {
            bool bRet = SaveQuytrinh(txtConfig, Configuration.QUY_TRINH_DI);
            return this.RedirectToAction("Quytrinhdi", "Admin");
        }

        public ActionResult Quytrinhden()
        {
            return GetQuytrinh(Configuration.QUY_TRINH_DEN);
        }

        [HttpPost]
        public ActionResult Quytrinhden_Save(string txtConfig)
        {
            bool bRet = SaveQuytrinh(txtConfig, Configuration.QUY_TRINH_DEN);
            return this.RedirectToAction("Quytrinhden", "Admin");
        }

        public AjaxStoreResult NhanvienList(string phong, int state, int start, int limit)
        {
            var query = from nv in DBContext.DMNHANVIENs
                        join c in DBContext.DMCHUCVUs on nv.CHUCVU equals c.MACHUCVU into nhanvien
                        from o in nhanvien.DefaultIfEmpty()
                        from p in DBContext.DMPHONGBANs
                            .Where(p => p.MAPHONG == nv.MAPHONG)
                            .DefaultIfEmpty()
                         select new
                        {
                            MANV = nv.MANV,
                            TEN = nv.TEN,
                            USERNAME = nv.USERNAME,
                            PASSWORD = nv.PASSWORD,
                            TRANGTHAI = nv.TRANGTHAI,
                            NICKYAHOO = nv.NICKYAHOO,
                            NICKSKYPE = nv.NICKSKYPE,
                            EMAIL = nv.EMAIL,
                            MOBILE = nv.MOBILE,
                            DIACHI = nv.DIACHI,
                            CHUCVU = nv.CHUCVU,
                            OFFICEPHONE = nv.OFFICEPHONE,
                            ADMIN = nv.ADMIN,
                            MAPHONG = nv.MAPHONG,
                            TENPHONG = p.TENPHONG,
                            TENCHUCVU = o.TENCHUCVU
                        };
            
            if (state != 2) // Is not "Tat ca"
            {
                query = from nv in query.Where(nv => nv.TRANGTHAI == state) select nv;
            }

            if (phong.Length > 0)
            {
                query = from nv in query.Where(nv => nv.MAPHONG == phong) select nv;
            }

            int nCount = query.ToList().Count;
            return new AjaxStoreResult(query.OrderBy(nv => nv.TEN).Skip(start).Take(limit), nCount);
        }


        protected int GetNewDanhmucID()
        {
            QLVBEntities db = this.DBContext;
            if (db.Connection.State == System.Data.ConnectionState.Closed)
                db.Connection.Open();


            ObjectResult<int?> n = db.GetNewSeqVal("Danhmuc_seq");

            foreach (int i in n)
            {
                return i;
            }

            return 0;
        }

        protected bool IsUserNameExist(string sUserName)
        {
            var query = from nv in DBContext.DMNHANVIENs.Where(nv => nv.USERNAME.ToLower() == sUserName.ToLower())
                        select nv;
            return (query.Count() != 0);
        }

        [HttpPost]
        public ActionResult NhanvienList_Save()
        {
            string sMaNhanvien;
            int nNhanvienID;
            AjaxStoreResult ajaxStoreResult = new AjaxStoreResult(StoreResponseFormat.Save);

            try
            {
                QLVBEntities db = this.DBContext;
                StoreDataHandler dataHandler = new StoreDataHandler(HttpContext.Request["data"]);
                ChangeRecords<DMNHANVIEN> data = dataHandler.ObjectData<DMNHANVIEN>();
                var qrChucvu = from cn in db.DMCHUCVUs.Where(cn => cn.MACHUCNANG != "01" && cn.MACHUCNANG != "02")
                                 select cn;
                
                foreach (DMNHANVIEN c in data.Deleted)
                {
                    db.DMNHANVIENs.Attach(c);
                    db.DMNHANVIENs.DeleteObject(c);
                }

                foreach (DMNHANVIEN c in data.Created)
                {
                    if (IsUserNameExist(c.USERNAME))
                    {
                        throw new Exception("Tên đăng nhập đã được sử dụng " + c.TEN + "(" + c.USERNAME + ")");
                    }

                    if (qrChucvu.Any(p => p.MACHUCVU == c.CHUCVU) && c.MAPHONG.Length == 0)
                    {
                        throw new Exception("Chưa chọn phòng cho nhân viên " + c.TEN);
                    }

                    nNhanvienID = GetNewNhanvienID();
                    string s = c.MAPHONG;
                    if (s.Length == 0) s = "00";
                    sMaNhanvien = s + nNhanvienID.ToString("D6");

                    c.MANV = sMaNhanvien;
                    db.DMNHANVIENs.AddObject(c);
                }

                foreach (DMNHANVIEN c in data.Updated)
                {
                    if (qrChucvu.Any(p => p.MACHUCVU == c.CHUCVU) && c.MAPHONG.Length == 0)
                    {
                        throw new Exception("Chưa chọn phòng cho nhân viên " + c.TEN);
                    }

                    var orgRecord = db.DMNHANVIENs.Single(p => p.MANV == c.MANV);
                    
                    //string sCurMaNV = c.MANV;
                    //sCurMaNV = sCurMaNV.Substring(2);
                    //sCurMaNV = c.MAPHONG + sCurMaNV;
                    db.DMNHANVIENs.ApplyCurrentValues(c);
                }

                db.SaveChanges();

            }
            catch (Exception e)
            {
                ajaxStoreResult.SaveResponse.Success = false;
                int nCode = System.Runtime.InteropServices.Marshal.GetHRForException(e);

                if( e.InnerException != null)
                {
                    ajaxStoreResult.SaveResponse.Message = e.InnerException.Message;
                } else
                {
                    ajaxStoreResult.SaveResponse.Message = e.Message;
                }
            }

            return ajaxStoreResult;
        }

        public ActionResult LoaiVanban()
        {
            return View();
        }

        public AjaxStoreResult LoaiVanbanList()
        {
            var query = from c in DBContext.DMLOAIVBs
                        select new
                        {
                            IDLOAIVB = c.IDLOAIVB,
                            LOAIVB = c.LOAIVB
                        };
            int nCount = query.ToList().Count;
            return new AjaxStoreResult(query, nCount);
        }

        [HttpPost]
        public ActionResult LoaiVanbanList_Save()
        {
            AjaxStoreResult ajaxStoreResult = new AjaxStoreResult(StoreResponseFormat.Save);

            try
            {
                QLVBEntities db = this.DBContext;
                StoreDataHandler dataHandler = new StoreDataHandler(HttpContext.Request["data"]);
                ChangeRecords<DMLOAIVB> data = dataHandler.ObjectData<DMLOAIVB>();

                foreach (DMLOAIVB c in data.Deleted)
                {
                    db.DMLOAIVBs.Attach(c);
                    db.DMLOAIVBs.DeleteObject(c);
                }

                foreach (DMLOAIVB c in data.Created)
                {
                    c.IDLOAIVB = GetNewDanhmucID();
                    db.DMLOAIVBs.AddObject(c);
                }

                foreach (DMLOAIVB c in data.Updated)
                {
                    var orgRecord = db.DMLOAIVBs.Single(p => p.IDLOAIVB == c.IDLOAIVB);
                    db.DMLOAIVBs.ApplyCurrentValues(c);
                }

                db.SaveChanges();

            }
            catch (Exception e)
            {
                ajaxStoreResult.SaveResponse.Success = false;
                int nCode = System.Runtime.InteropServices.Marshal.GetHRForException(e);

                ajaxStoreResult.SaveResponse.Message = e.InnerException.Message;
            }

            return ajaxStoreResult;
        }


        public ActionResult SoVanban()
        {
            return View();
        }

        public AjaxStoreResult SoVanbanList()
        {
            var query = from c in DBContext.DMSOVBs
                        select new
                        {
                            IDSOVB = c.IDSOVB,
                            TENSOVB = c.TENSOVB
                        };
            int nCount = query.ToList().Count;
            return new AjaxStoreResult(query, nCount);
        }

        [HttpPost]
        public ActionResult SoVanbanList_Save()
        {
            AjaxStoreResult ajaxStoreResult = new AjaxStoreResult(StoreResponseFormat.Save);

            try
            {
                QLVBEntities db = this.DBContext;
                StoreDataHandler dataHandler = new StoreDataHandler(HttpContext.Request["data"]);
                ChangeRecords<DMSOVB> data = dataHandler.ObjectData<DMSOVB>();

                foreach (DMSOVB c in data.Deleted)
                {
                    db.DMSOVBs.Attach(c);
                    db.DMSOVBs.DeleteObject(c);
                }

                foreach (DMSOVB c in data.Created)
                {
                    c.IDSOVB = GetNewDanhmucID();
                    db.DMSOVBs.AddObject(c);
                }

                foreach (DMSOVB c in data.Updated)
                {
                    var orgRecord = db.DMSOVBs.Single(p => p.IDSOVB == c.IDSOVB);
                    db.DMSOVBs.ApplyCurrentValues(c);
                }

                db.SaveChanges();

            }
            catch (Exception e)
            {
                ajaxStoreResult.SaveResponse.Success = false;
                int nCode = System.Runtime.InteropServices.Marshal.GetHRForException(e);

                ajaxStoreResult.SaveResponse.Message = e.InnerException.Message;
            }

            return ajaxStoreResult;
        }
    }
}
