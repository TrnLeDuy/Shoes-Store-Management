//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WEB_CSDL_DEMO.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class CHITIET_PHIEUNHAP
    {
        public string MaPNH { get; set; }
        public string MaSP { get; set; }
        public string MaKC { get; set; }
        public int SoLuongNhap { get; set; }
        public decimal DonGiaNhap { get; set; }
        public int TinhTrang { get; set; }
    
        public virtual KICHCO_SANPHAM KICHCO_SANPHAM { get; set; }
        public virtual PHIEUNHAPHANG PHIEUNHAPHANG { get; set; }
    }
}
