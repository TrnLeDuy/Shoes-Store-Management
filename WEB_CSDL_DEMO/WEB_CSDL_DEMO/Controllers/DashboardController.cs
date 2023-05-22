using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WEB_CSDL_DEMO.Models;

namespace WEB_CSDL_DEMO.Controllers
{
    public class DashboardController : Controller
    {
        private fashionDatabaseEntities db = new fashionDatabaseEntities();
        private int total = 0;
        private decimal total_money = 0;


        // GET: Dashboard
        public ActionResult Dashboard()
        {
            foreach (var entity in db.KICHCO_SANPHAM)
            {
                total += entity.SoLuong;
            }

            foreach (var money in db.DONHANGs)
            {
                if(money.TrangThaiDH == 1)
                {
                    total_money += money.TongTien;
                }
            }

            ViewBag.countSanPham = total;
            ViewBag.countDonHang = db.DONHANGs.Count();
            ViewBag.countKhachHang = db.KHACHHANGs.Count();
            ViewBag.countNhanVien = db.NHANVIENs;
            ViewBag.countDoanhThu = total_money;
            return View();
        }
    }
}