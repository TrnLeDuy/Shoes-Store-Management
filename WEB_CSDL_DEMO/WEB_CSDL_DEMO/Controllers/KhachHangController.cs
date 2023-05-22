using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WEB_CSDL_DEMO.Models.KhachHangModel;
using WEB_CSDL_DEMO.Models;

namespace WEB_CSDL_DEMO.Controllers
{
    public class KhachHangController : Controller
    {
        fashionDatabaseEntities db = new fashionDatabaseEntities();
        // GET: KhachHang
        public ActionResult Index()
        {
            var model = db.V_KHACHHANG_DS.ToList();
            return View(model);
        }

        public ActionResult ThemKhachHang(KhachHang model)
        {
            // Instantiate an instance of the model
            if (ModelState.IsValid)
            {
                // Instantiate an instance of your ADO.NET model class
                sp_KhachHang sp = new sp_KhachHang();
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
            sp_KhachHang sp = new sp_KhachHang();
            sp.XoaKhachHang(maKH);

            // Redirect to appropriate view or action
            return RedirectToAction("Index");
        }
    }
}