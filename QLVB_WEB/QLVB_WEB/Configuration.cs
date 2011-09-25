using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace QLVB_WEB
{
    public class Configuration
    {
        public static string QUY_TRINH_DI = "QUY_TRINH_DI";
        public static string QUY_TRINH_DEN = "QUY_TRINH_DEN";
    }

    public class QUYTRINH_POSITION
    {
        public string sID { get; set; }
        public int OffsetLeft { get; set; }
        public int OffsetTop { get; set; }

        public QUYTRINH_POSITION()
        {
        }

        public QUYTRINH_POSITION(string s, int left, int top)
        {
            sID = s;
            OffsetTop = top;
            OffsetLeft = left;
        }

    }

    public class QUYTRINH_CONNECTION
    {
        public string SourceID { get; set; }
        public string TargetID { get; set; }

        public QUYTRINH_CONNECTION(string id1, string id2)
        {
            SourceID = id1;
            TargetID = id2;
        }
    }
}