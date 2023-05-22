using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace WebApplication1.Models.KhachHangModel
{
    public class ThemKhachHang
    {
            public string MaKH { get; set; }
            public string HoTen { get; set; }
            public string SDT { get; set; }
            public string DiaChi { get; set; }
            public string Email { get; set; }
            public DateTime NgaySinh { get; set; }
            public string GioiTinh { get; set; }
        

    }



}