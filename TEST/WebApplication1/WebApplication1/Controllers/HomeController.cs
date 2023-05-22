using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models.NVModel;

namespace WebApplication1.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult NVien() 
        {
            NhanVien nvmodel =  new NhanVien();
            DataTable nhanvienTable = nvmodel.GetNhanVienData();
            ViewBag.NhanVienData = nhanvienTable;


            // Retrieve data from the V_NHANVIEN_DS view and populate the DataTable

            return View();
        }
        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}