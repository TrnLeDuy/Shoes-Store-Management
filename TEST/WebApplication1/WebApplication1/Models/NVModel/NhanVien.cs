using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApplication1.Models.NVModel
{
    public class NhanVien
    {
        public NhanVien() { }   

        public DataTable GetNhanVienData()
        {
            DataTable nhanvienTable = new DataTable();

            // Connection string to the database
            string connectionString = "data source=192.168.1.11,1433;initial catalog=fashionDatabase;persist security info=True;user id=sa;password=Kha019283;";

            // SQL query to retrieve data from the V_NHANVIEN_DS view
            string query = "SELECT [MaNV], [HoTen], [SDT], [Email], [TenCV], [TenPB] FROM [dbo].[V_NHANVIEN_DS]";

            // Create a SqlConnection using the connection string
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create a SqlCommand with the SQL query and SqlConnection
                SqlCommand command = new SqlCommand(query, connection);

                // Open the database connection
                connection.Open();

                // Create a SqlDataReader to read the data
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    // Load the data into the DataTable
                    nhanvienTable.Load(reader);
                }
            }

            return nhanvienTable;
        }
    }
}