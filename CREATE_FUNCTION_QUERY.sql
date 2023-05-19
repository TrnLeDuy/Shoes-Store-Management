USE [fashionDatabase]
GO

CREATE OR ALTER FUNCTION fn_TimKiem_TenPhongBan
(
    @tenpb nvarchar(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM PHONGBAN
    WHERE TenPB LIKE '%' + @tenpb + '%'
);

GO

CREATE OR ALTER FUNCTION fn_TimKiem_NhanVien_TheoTen 
(
    @tennv nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT *
    FROM NHANVIEN
    WHERE HoTen LIKE '%' + @tennv + '%'
);

GO

CREATE OR ALTER FUNCTION fn_Tinh_ThanhTien_SanPham
(
    @soluong int,
	@dongia numeric(18,0)
)
RETURNS decimal(18,2) 
AS
BEGIN
	DECLARE @thanhtien decimal(18,2)
	SET @thanhtien = @soluong * @dongia;
	RETURN @thanhtien;
END;

GO

CREATE OR ALTER FUNCTION fn_TimKiem_LoaiSanPham
(
	@tenloaisp nvarchar(100)
)
RETURNS TABLE
AS
RETURN
(
	SELECT *
	FROM LOAISANPHAM
	WHERE TenLoaiSP = @tenloaisp
);

GO

CREATE OR ALTER FUNCTION fn_TimKiem_SanPham
(
    @tensp nvarchar(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM SANPHAM
    WHERE TenSP LIKE '%' + @tensp + '%'
);

GO

CREATE OR ALTER FUNCTION fn_TimKiem_NhaCungCap
(
    @tenncc nvarchar(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM NHACUNGCAP
    WHERE TenNCC LIKE '%' + @tenncc + '%'
);

GO

CREATE OR ALTER FUNCTION fn_TimKiem_ChucVu
(
    @tencv nvarchar(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM CHUCVU
    WHERE TenCV LIKE '%' + @tencv + '%'
);

GO

CREATE OR ALTER FUNCTION fn_TimKiem_PhieuMuaHang
(
    @mapmh char(10)
)
RETURNS TABLE
AS
RETURN
(
    SELECT pm.MaPNH, pm.NgayNhap, pm.MaNV,pm.MaNCC, ct.MaSP,ct.SoLuongNhap , ct.DonGiaNhap, ct.MaKC, ct.TinhTrang
    FROM PHIEUNHAPHANG pm
	INNER JOIN CHITIET_PHIEUNHAP ct ON ct.MaPNH = pm.MaPNH
    WHERE pm.MaPNH LIKE @mapmh
);

GO

CREATE OR ALTER FUNCTION fn_TinhTongDoanhThuTheoThang
(
    @thang INT,
    @nam INT
)
RETURNS decimal
AS
BEGIN
    DECLARE @tongtien decimal

    SELECT @tongtien = SUM(TongTien)
    FROM DONHANG
    WHERE MONTH(NgayDatHang) = @thang AND YEAR(NgayDatHang) = @nam

    RETURN @tongtien
END

GO

CREATE OR ALTER FUNCTION fn_TimKiem_KHACHHANG
(
    @tenkh nvarchar(100)
)

RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM KHACHHANG
    WHERE HoTen LIKE '%' + @tenkh + '%'
);

GO

CREATE OR ALTER FUNCTION fn_TimKiem_DONHANG
(
    @madh char(10)
)

RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM DONHANG
    WHERE MaDH LIKE '%' + @madh + '%'
);
