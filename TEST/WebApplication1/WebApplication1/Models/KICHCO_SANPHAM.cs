//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplication1.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class KICHCO_SANPHAM
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KICHCO_SANPHAM()
        {
            this.CHITIET_DONHANG = new HashSet<CHITIET_DONHANG>();
            this.CHITIET_PHIEUNHAP = new HashSet<CHITIET_PHIEUNHAP>();
        }
    
        public string MaSP { get; set; }
        public string MaKC { get; set; }
        public int SoLuong { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CHITIET_DONHANG> CHITIET_DONHANG { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CHITIET_PHIEUNHAP> CHITIET_PHIEUNHAP { get; set; }
        public virtual KICHCO KICHCO { get; set; }
        public virtual SANPHAM SANPHAM { get; set; }
    }
}
