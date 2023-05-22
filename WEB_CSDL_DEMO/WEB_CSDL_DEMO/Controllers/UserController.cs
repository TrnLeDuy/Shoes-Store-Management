using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.Mvc;
using WEB_CSDL_DEMO.Models;

namespace QuanLyBanGiay.Controllers
{
    public class UserController : Controller
    {
        private fashionDatabaseEntities db = new fashionDatabaseEntities();

        // GET: Authencation
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login([Bind(Include = "Username, UserPass")] NHANVIEN adUser)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(adUser.Username))
                    return View(adUser);
                if (string.IsNullOrEmpty(adUser.UserPass))
                    return View(adUser);
                if (ModelState.IsValid)
                {
                    //Tìm người dùng có tên đăng nhập và password hợp lệ trong CSDL
                    var user = db.NHANVIENs.FirstOrDefault(k => k.Username == adUser.Username && k.UserPass == adUser.UserPass);
                    if (user.TrangThai == 0)
                    {
                        ViewBag.ThongBao = "Tài khoản này đã bị khóa!";
                    }
                    else
                    if (user != null)
                    {
                        //Lưu thông vào session
                        Session["Account"] = user;
                        Session["Username"] = user.Username;
                        Session["Fullname"] = user.HoTen;
                        Session["ID"] = user.MaNV;
                        Session["Role"] = user.MaCV;
                        return Redirect("~/Dashboard/Dashboard");
                    }
                    else
                        ViewBag.ThongBao = "Tên đăng nhập hoặc mật khẩu không đúng!";
                }
            }
            return View();
        }

        //Đăng xuất
        public ActionResult Logout()
        {
            //Perform any necessary cleanup or logging out of the user
            //Remove any authentication cookies or session state information
            //Redirect the user to the login page
            Session["Account"] = null;
            Session["Fullname"] = null;
            Session["Username"] = null;
            Session["ID"] = null;
            Session["Role"] = null;
            Session.Abandon();
            return RedirectToAction("Login");
        }
    }
}