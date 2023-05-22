using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Configuration;
using static System.Net.Mime.MediaTypeNames;

namespace WebApplication1.Models.KhachHangModel
{
    public class sp_ThemKH
    {
        public sp_ThemKH()
        { }
        string connectionString = "data source=192.168.1.11,1433;initial catalog=fashionDatabase;persist security info=True;user id=sa;password=Kha019283;";

        public void ThemKhachHang(ThemKhachHang model)
        {
            //Data Source = 192.168.111.170,1433; Initial Catalog = fashionDatabase; Persist Security Info = True; User ID = sa; Password = ***********; Multiple Active Result Sets = True; Application Name = EntityFramework
            string sp = "sp_ThemKhachHang";

           

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(sp, connection);
                command.CommandType = CommandType.StoredProcedure;

                // Add input parameters to the command
                //command.Parameters.AddWithValue("@makh", model.MaKH);
                command.Parameters.AddWithValue("@hoten", model.HoTen);
                command.Parameters.AddWithValue("@sdt", model.SDT);
                command.Parameters.AddWithValue("@diachi", model.DiaChi);
                command.Parameters.AddWithValue("@email", model.Email);
                command.Parameters.AddWithValue("@ngaysinh", model.NgaySinh);
                command.Parameters.AddWithValue("@gioitinh", model.GioiTinh);

                connection.Open();

                command.ExecuteNonQuery();
            }
        }

        public void XoaKhachHang(string maKH)
        {
            string sp = "sp_XoaKhachHang";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(sp, connection);
                command.CommandType = CommandType.StoredProcedure;

                // Add input parameter for the stored procedure
                command.Parameters.AddWithValue("@MaKH", maKH);

                connection.Open();

                command.ExecuteNonQuery();
            }
        }

    }
}