using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;
using WebApplication1.Models.KhachHangModel;
using System.Data.SqlClient;

namespace WebApplication1.Controllers
{
    public class DonHangController : Controller
    {
        fashionDatabaseEntities db = new fashionDatabaseEntities();
        // GET: DonHang
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ThemKhachHang(ThemKhachHang model)
        {
            // Instantiate an instance of the model
            if (ModelState.IsValid)
            {
                // Instantiate an instance of your ADO.NET model class
                sp_ThemKH sp = new sp_ThemKH();
                sp.ThemKhachHang(model);

                // Redirect to appropriate view or action
                return RedirectToAction("Index");
            }

            // If the model state is not valid, return the view with validation errors
            return View(model);
        }

        public ActionResult XoaKhachHang(string maKH)
        {
            // Instantiate an instance of your ADO.NET model class
            sp_ThemKH sp = new sp_ThemKH();
            sp.XoaKhachHang(maKH);

            // Redirect to appropriate view or action
            return RedirectToAction("Index");
        }



    }
}