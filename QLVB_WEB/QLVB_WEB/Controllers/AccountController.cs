﻿using System;
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
    [HandleError]
    public class AccountController : BaseController
    {
        // This constructor is used by the MVC framework to instantiate the controller using
        // the default forms authentication and membership providers.
        public AccountController() : this(null, null) { }

        // This constructor is not used by the MVC framework but is instead provided for ease
        // of unit testing this type. See the comments at the end of this file for more
        // information.
        public AccountController(IFormsAuthentication formsAuth, IMembershipService service)
        {
            this.FormsAuth = formsAuth ?? new FormsAuthenticationService();
            this.MembershipService = service ?? new AccountMembershipService();
        }

        public IFormsAuthentication FormsAuth
        {
            get;
            private set;
        }

        public IMembershipService MembershipService
        {
            get;
            private set;
        }

        public ActionResult Login()
        {
            return this.View();
        }

        private string SHA512Hash(string st)
        {
            SHA512Managed sha = new SHA512Managed();
            byte[] hash = sha.ComputeHash(System.Text.Encoding.UTF8.GetBytes(st));

            string hex = BitConverter.ToString(hash);
            hex = hex.Replace("-", "").ToLower();

            return hex;
        }

        public string EncryptPassword(string txtPassword)
        {
            if (txtPassword == null) txtPassword = "";
            string sHashPassword = SHA512Hash(txtPassword);

            //var res = new JsonResult();
            //res.Data = new { serviceResponse = new { valid = true, message = sHashPassword } };
            //return res;
            return sHashPassword;

        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Login2(string txtUsername, string txtPassword, string returnUrl)
        {
            string sHashPassword = SHA512Hash(txtPassword);
            txtUsername = txtUsername.ToLower();
            if (!ValidateLogOn(txtUsername, txtPassword))
            {
                return new AjaxResult { ErrorMessage = "Tên hoặc mật mã không đúng." };
            }

            try
            {
                DBContext.Connection.Open();
                var query = from c in DBContext.DMNHANVIENs.Where(c => c.USERNAME.ToLower() == txtUsername && 
                    c.PASSWORD == sHashPassword)
                         select c;

                int nCount = query.Count();
                if (nCount == 0)
                {
                    return new AjaxResult { ErrorMessage = "Tên hoặc mật mã không đúng." };
                }
                foreach (DMNHANVIEN nv in query)
                {
                    if (nv.TRANGTHAI != 1)
                        return new AjaxResult { ErrorMessage = "Tài khoản này hiện đang đặt ở chế độ không hoạt động." };
                    break;
                }
            }

            catch (Exception e)
            {
                return new AjaxResult { ErrorMessage = "Lỗi kết nối với DB lúc đăng nhập.\nLỗi: " + e.Message};
            }

            this.FormsAuth.SignIn(txtUsername, true);

            // Store last user
            HttpCookie cookie = new HttpCookie("LastUserID");
            cookie.Value = txtUsername;
            cookie.Expires = DateTime.Now.AddDays(1000);
            this.ControllerContext.HttpContext.Response.Cookies.Add(cookie);

            if (!String.IsNullOrEmpty(returnUrl))
            {
                if (Url.IsLocalUrl(returnUrl))
                {
                    //return Redirect(returnUrl);
                } 
                else
                {
                    return this.RedirectToAction("Index", "Home");
                }
            }
            
            return this.RedirectToAction("Index", "Home");
        }

        public ActionResult Logout()
        {
            this.FormsAuth.SignOut();
            return RedirectToAction("Index", "Home");
        }


        [Authorize]
        public ActionResult ChangePassword()
        {
            this.ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
            return this.View();
        }

        [Authorize]
        [AcceptVerbs(HttpVerbs.Post)]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1031:DoNotCatchGeneralExceptionTypes",
            Justification = "Exceptions result in password not being changed.")]
        public ActionResult ChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {

            this.ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            if (!ValidateChangePassword(currentPassword, newPassword, confirmPassword))
            {
                return this.View();
            }

            try
            {
                if (MembershipService.ChangePassword(User.Identity.Name, currentPassword, newPassword))
                {
                    return RedirectToAction("Đổi mật mã thành công.");
                }
                else
                {
                    this.ModelState.AddModelError("_FORM", "Mật mã hiện tại hoặc mật mã mới không hợp lệ.");
                    return this.View();
                }
            }
            catch
            {
                this.ModelState.AddModelError("_FORM", "Mật mã hiện tại hoặc mật mã mới không hợp lệ.");
                return this.View();
            }
        }

        public ActionResult ChangePasswordSuccess()
        {
            return this.View();
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.User.Identity is WindowsIdentity)
            {
                throw new InvalidOperationException("Windows authentication is not supported.");
            }
        }

        #region Validation Methods

        private bool ValidateChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {
            if (String.IsNullOrEmpty(currentPassword))
            {
                this.ModelState.AddModelError("currentPassword", "You must specify a current password.");
            }
            if (newPassword == null || newPassword.Length < MembershipService.MinPasswordLength)
            {
                this.ModelState.AddModelError("newPassword",
                    String.Format(CultureInfo.CurrentCulture,
                         "You must specify a new password of {0} or more characters.",
                         MembershipService.MinPasswordLength));
            }

            if (!String.Equals(newPassword, confirmPassword, StringComparison.Ordinal))
            {
                this.ModelState.AddModelError("_FORM", "The new password and confirmation password do not match.");
            }

            return this.ModelState.IsValid;
        }

        private bool ValidateLogOn(string userName, string password)
        {
            if (String.IsNullOrEmpty(userName))
            {
                this.ModelState.AddModelError("username", "Hãy nhập tên đăng nhập.");
            }
            if (String.IsNullOrEmpty(password))
            {
                this.ModelState.AddModelError("password", "Hãy nhập mật mã.");
            }
            if (!MembershipService.ValidateUser(userName, password))
            {
                this.ModelState.AddModelError("_FORM", "Tên đăng nhập hoặc mật mã không đúng.");
            }

            return this.ModelState.IsValid;
        }

        private bool ValidateRegistration(string userName, string email, string password, string confirmPassword)
        {
            if (String.IsNullOrEmpty(userName))
            {
                this.ModelState.AddModelError("username", "You must specify a username.");
            }
            if (String.IsNullOrEmpty(email))
            {
                this.ModelState.AddModelError("email", "You must specify an email address.");
            }
            if (password == null || password.Length < MembershipService.MinPasswordLength)
            {
                this.ModelState.AddModelError("password",
                    String.Format(CultureInfo.CurrentCulture,
                         "You must specify a password of {0} or more characters.",
                         MembershipService.MinPasswordLength));
            }
            if (!String.Equals(password, confirmPassword, StringComparison.Ordinal))
            {
                this.ModelState.AddModelError("_FORM", "The new password and confirmation password do not match.");
            }
            return this.ModelState.IsValid;
        }

        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://msdn.microsoft.com/en-us/library/system.web.security.membershipcreatestatus.aspx for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Username already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A username for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication this.provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion
    }

    // The FormsAuthentication type is sealed and contains static members, so it is difficult to
    // unit test code that calls its members. The interface and helper class below demonstrate
    // how to create an abstract wrapper around such a type in order to make the AccountController
    // code unit testable.

    public interface IFormsAuthentication
    {
        void SignIn(string userName, bool createPersistentCookie);
        void SignOut();
    }

    public class FormsAuthenticationService : IFormsAuthentication
    {
        public void SignIn(string userName, bool createPersistentCookie)
        {
            FormsAuthentication.SetAuthCookie(userName, createPersistentCookie);
        }
        public void SignOut()
        {
            FormsAuthentication.SignOut();
        }
    }

    public interface IMembershipService
    {
        int MinPasswordLength { get; }

        bool ValidateUser(string userName, string password);
        MembershipCreateStatus CreateUser(string userName, string password, string email);
        bool ChangePassword(string userName, string oldPassword, string newPassword);
    }

    public class AccountMembershipService : IMembershipService
    {
        private MembershipProvider provider;

        public AccountMembershipService() : this(null) { }

        public AccountMembershipService(MembershipProvider provider)
        {
            this.provider = this.provider ?? Membership.Provider;
        }

        public int MinPasswordLength
        {
            get
            {
                return this.provider.MinRequiredPasswordLength;
            }
        }

        public bool ValidateUser(string userName, string password)
        {
            //return (userName.Equals("demo") && password.Equals("demo"));
            //return this.provider.ValidateUser(userName, password);
            return true;
        }

        public MembershipCreateStatus CreateUser(string userName, string password, string email)
        {
            MembershipCreateStatus status;
            this.provider.CreateUser(userName, password, email, null, null, true, null, out status);
            return status;
        }

        public bool ChangePassword(string userName, string oldPassword, string newPassword)
        {
            MembershipUser currentUser = this.provider.GetUser(userName, true /* userIsOnline */);
            return currentUser.ChangePassword(oldPassword, newPassword);
        }
    }
}