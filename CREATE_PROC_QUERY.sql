USE [fashionDatabase]
GO

--Store PROC thêm phòng ban
CREATE OR ALTER PROC sp_ThemPhongBan 
	@mapb CHAR(10), 
	@tenpb NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT * FROM PHONGBAN WHERE MaPB = @mapb)
		BEGIN
			INSERT INTO PHONGBAN (MaPB, TenPB)
			VALUES (@mapb, @tenpb);
			PRINT N'Thêm phòng ban thành công';
		END;
	ELSE
		RAISERROR(N'Đã tồn tại mã phòng ban: %s', 16, 1, @mapb);
END;

GO

--Store PROC xóa phòng ban
CREATE OR ALTER PROC sp_XoaPhongBan
    @mapb CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM PHONGBAN WHERE MaPB = @mapb)
		BEGIN
			DELETE FROM PHONGBAN WHERE MaPB = @mapb;
			PRINT N'Xóa phòng ban thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy phòng ban có mã: %s.', 16, 1, @mapb);   
END;

GO

--Store PROC cập nhật phòng ban
CREATE OR ALTER PROC sp_CapNhatPhongBan
    @mapb CHAR(10),
	@tenpb NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM PHONGBAN WHERE MaPB = @mapb)
		BEGIN
			UPDATE PHONGBAN
			SET TenPB = @tenpb
			WHERE MaPB = @mapb;
			PRINT N'Cập nhật phòng ban thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy phòng ban có mã: %s.', 16, 1, @mapb);   
END;

GO

--Store PROC thêm nhân viên
CREATE OR ALTER PROC sp_ThemNhanVien
	@manv CHAR(10), @hoten NVARCHAR(100),
	@sdt CHAR(11), @email CHAR(100),
	@ngaysinh DATE, @gioitinh CHAR(1),
	@diachi NVARCHAR(200), @username CHAR(50),
	@userpASs CHAR(30), @tinhtrang INT,
	@macv CHAR(10), @mapb CHAR(10)
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE MaNV = @manv)
		BEGIN
			INSERT INTO NHANVIEN (MaNV, HoTen, SDT, Email, NgaySinh, GioiTinh, DiaChi, Username, UserPASs, TrangThai, MaCV, MaPB)
			VALUES (@manv, @hoten, @sdt, @email, @ngaysinh, @gioitinh, @diachi, @username, @userpASs, @tinhtrang, @macv, @mapb);
			PRINT N'Thêm nhân viên thành công';
		END;
	ELSE
		RAISERROR(N'Đã tồn tại mã nhân viên: %s', 16, 1, @manv);
END;

GO

--Store PROC xóa nhân viên
CREATE OR ALTER PROC sp_XoaNhanVien
    @manv CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM NHANVIEN WHERE MaNV = @manv)
		BEGIN
			DELETE FROM NHANVIEN WHERE MaNV = @manv;
			PRINT N'Xóa nhân viên thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy nhân viên có mã: %s.', 16, 1, @manv);   
END;

GO

--Store PROC cập nhật nhân viên
CREATE OR ALTER PROC sp_CapNhatNhanVien
    @manv CHAR(10), @hoten NVARCHAR(100),
	@sdt CHAR(11), @email CHAR(100),
	@ngaysinh DATE, @gioitinh CHAR(1),
	@diachi NVARCHAR(200), @username CHAR(50),
	@userpASs CHAR(30), @tinhtrang INT,
	@macv CHAR(10), @mapb CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM NHANVIEN WHERE MaNV = @manv)
		BEGIN
			UPDATE NHANVIEN
			SET HoTen = @hoten, SDT = @sdt, Email = @email,
				NgaySinh = @ngaysinh, GioiTinh = @gioitinh, 
				DiaChi = @diachi, Username = @username, 
				UserPASs = @userpASs, TrangThai = @tinhtrang, 
				MaCV = @macv, MaPB = @mapb
			WHERE MaNV = @manv;
			PRINT N'Cập nhật nhân viên thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy nhân viên có mã: %s.', 16, 1, @manv);   
END;

GO

--Store PROC tổng số nhân viên với tình trạng nghỉ việc
CREATE OR ALTER PROC sp_Tong_NhanVien_NghiViec
AS
BEGIN
	SELECT COUNT(*) AS TongSoNhanVienNghiViec
    FROM NHANVIEN
    WHERE TrangThai = 0; -- 0 là tình trạng nghỉ việc
END;

GO

--Store PROC tổng số nhân viên hiện đang làm việc
CREATE OR ALTER PROC sp_Tong_NhanVien_DangLamViec
AS
BEGIN
	SELECT COUNT(*) AS TongSoNhanViENDangLamViec
    FROM NHANVIEN
    WHERE TrangThai != 0; 
END;

GO

--Store PROC tìm kiếm nhân viên thuộc phòng ban
CREATE OR ALTER PROC sp_TimKiem_NhanVien_Thuoc_PhongBan
(
    @tenpb NVARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM NHANVIEN
    WHERE MaPB IN (
        SELECT MaPB
        FROM dbo.fn_TimKiem_TenPhongBan(@tenpb)
    );
END;

GO

--Store PROC tìm kiếm nhân viên theo tên
CREATE OR ALTER PROC sp_TimKiem_NhanVien_TheoTen
    @tennv NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM dbo.fn_TimKiem_NhanVien_TheoTen(@tennv);
END;

GO

--Store PROC tính tổng tiền đơn hàng
CREATE OR ALTER PROC sp_Tinh_TongTien_DonHang
    @madh CHAR(10)
AS
BEGIN
    SELECT MaDH,SUM(dbo.fn_Tinh_ThanhTien_SanPham(SoLuong, GiaTien)) AS TongTien
    FROM CHITIET_DONHANG
    WHERE MaDH = @madh
	GROUP BY MADH
END;

GO

--Store PROC thêm nhà cung cấp
CREATE OR ALTER PROC sp_ThemNhaCungCap 
	@mancc CHAR(10), 
	@tenncc NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT * FROM NHACUNGCAP WHERE MaNCC = @mancc)
		BEGIN
			INSERT INTO NHACUNGCAP (MaNCC, TenNCC)
			VALUES (@mancc, @tenncc);
			PRINT N'Thêm nhà cung cấp thành công';
		END;
	ELSE
		RAISERROR(N'Đã tồn tại mã nhà cung cấp: %s', 16, 1, @mancc);
END;

GO

--Store PROC xóa nhà cung cấp
CREATE OR ALTER PROC sp_XoaNhaCungCap
	@mancc CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM NHACUNGCAP WHERE MaNCC = @mancc)
		BEGIN
			DELETE FROM NHACUNGCAP WHERE MaNCC = @mancc;
			PRINT N'Xóa nhà cung cấp thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy nhà cung cấp có mã: %s.', 16, 1, @mancc);   
END;

GO

--Store PROC cập nhật nhà cung cấp
CREATE OR ALTER PROC sp_CapNhatNhaCungCap
    @mancc CHAR(10),
	@tenncc NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM NHACUNGCAP WHERE MaNCC = @mancc)
		BEGIN
			UPDATE NHACUNGCAP
			SET TenNCC = @tenncc
			WHERE MaNCC = @mancc;
			PRINT N'Cập nhật nhà cung cấp thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy nhà cung cấp có mã: %s.', 16, 1, @mancc);   
END;

GO

--Store PROC thêm sản phẩm
CREATE OR ALTER PROC sp_ThemSanPham 
	@tensp NVARCHAR(100),
	@giASp NUMERIC(18,0), @maloaisp CHAR(10), @mausac NVARCHAR(20), @chatlieu NVARCHAR(50), @doituong NVARCHAR(50), @tinhtrang INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @MASP CHAR(10)
    SELECT TOP 1 @MASP = MASP FROM SANPHAM WHERE MASP LIKE 'SP%' AND TenSP IS NULL ORDER BY MASP ASC

    IF @MASP IS NULL
    BEGIN
        DECLARE @lASt_MASP CHAR(10)
        SELECT TOP 1 @lASt_MASP = MASP FROM SANPHAM WHERE MASP LIKE 'SP%' ORDER BY MASP DESC
        DECLARE @next_MASP INT
        SET @next_MASP = CAST(RIGHT(@lASt_MASP, 8) AS INT) + 1
        SET @MASP = 'SP' + RIGHT('00000000' + CAST(@next_MASP AS VARCHAR(8)), 8)
    END
	IF NOT EXISTS (SELECT * FROM SANPHAM WHERE MASP = @mASp)
		BEGIN
			INSERT INTO SANPHAM (MASP, TenSP, GiaNhap, MaLoaiSP,MauSac,ChatLieu,DoiTuong,TinhTrangSP)
			VALUES (@mASp, @tensp, @giASp, @maloaisp, @mausac,@chatlieu,@doituong,@tinhtrang)
			PRINT N'Thêm sản phẩm thành công';
		END;
	ELSE
		RAISERROR(N'Đã tồn tại mã sản phẩm: %s', 16, 1, @mASp);
END;

GO

--Store PROC xóa sản phẩm
CREATE OR ALTER PROC sp_XoASanPham
	@mASp CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM SANPHAM WHERE MASP = @mASp)
		BEGIN
			DELETE FROM SANPHAM WHERE MASP = @mASp;
			PRINT N'Xóa sản phẩm thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy sản phẩm có mã: %s.', 16, 1, @mASp);   
END;

GO

--Store PROC cập nhật sản phẩm
CREATE OR ALTER PROC sp_CapNhatSanPham
	@mASp CHAR(10), @tensp NVARCHAR(100),
	@giASp NUMERIC(18,0), @maloaisp CHAR(10), @mausac NVARCHAR(20), @chatlieu NVARCHAR(50), @doituong NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM SANPHAM WHERE MASP = @mASp)
		BEGIN
			UPDATE SANPHAM
			SET TenSP = @tensp, GiaNhap = @giASp, 
				MaLoaiSP = @maloaisp, MauSac = @mausac, ChatLieu = @chatlieu, DoiTuong = @doituong
			WHERE MASP = @mASp;
			PRINT N'Cập nhật sản phẩm thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy sản phẩm có mã: %s.', 16, 1, @mASp);   
END;

GO

--Store PROC tính tổng số lượng sản phẩm còn kinh doanh
CREATE OR ALTER PROC sp_Tong_SanPham_DangKinhDoanh
AS
BEGIN
	SELECT COUNT(*) AS TongSoLuongSanPhamDangKinhDoanh
    FROM SANPHAM
    WHERE TinhTrangSP != 0; 
END;

GO

--Store PROC tinh tổng số lượng sản phẩm ngừng kinh doanh
CREATE OR ALTER PROC sp_Tong_SanPham_NgungKinhDoanh
AS
BEGIN
	SELECT COUNT(*) AS TongSoLuongSanPhamNgungKinhDoanh
    FROM SANPHAM
    WHERE TinhTrangSP = 0; -- 0 là tình trạng ngừng kinh doanh
END;

GO

--Store PROC tìm kiếm loại sản phẩm
CREATE OR ALTER PROC sp_TimKiem_LoaiSanPham
	@tenloaisp NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM dbo.fn_TimKiem_LoaiSanPham(@tenloaisp);
END;

GO

--Store PROC tìm kiếm sản phẩm
CREATE OR ALTER PROC sp_TimKiem_SanPham
	@tensp NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM dbo.fn_TimKiem_SanPham(@tensp);
END;

GO

--Store PROC tìm kiếm nhà cung cấp
CREATE OR ALTER PROC sp_TimKiem_NhaCungCap
	@tenncc NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM dbo.fn_TimKiem_NhaCungCap(@tenncc);
END;

GO

--Store PROC thêm chức vụ
CREATE OR ALTER PROC sp_ThemChucVu
	@macv CHAR(10), 
	@tencv NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT * FROM CHUCVU WHERE MaCV = @macv)
		BEGIN
			INSERT INTO CHUCVU(MaCV, TenCV)
			VALUES (@macv, @tencv);
			PRINT N'Thêm nhà chức vụ thành công';
		END;
	ELSE
		RAISERROR(N'Đã tồn tại mã chức vụ: %s', 16, 1, @macv);
END;

GO

--Store PROC xóa chức vụ
CREATE OR ALTER PROC sp_XoaChucVu
	@macv CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM CHUCVU WHERE MaCV = @macv)
		BEGIN
			DELETE FROM CHUCVU WHERE MaCV = @macv;
			PRINT N'Xóa chức vụ thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy chức vụ có mã: %s.', 16, 1, @macv);   
END;

GO

--Store PROC cập nhật chức vụ
CREATE OR ALTER PROC sp_CapNhatChucVu
    @macv CHAR(10),
	@tencv NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM CHUCVU WHERE MaCV = @macv)
		BEGIN
			UPDATE CHUCVU
			SET TenCV = @tencv
			WHERE MaCV = @macv;
			PRINT N'Cập nhật chức vụ thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy chức vụ có mã: %s.', 16, 1, @macv);   
END;

GO

--Store PROC thêm phiếu mua hàng
CREATE OR ALTER PROC sp_ThemPhieuNhapHang
	 @ngaynhap DATE,
	 @manv CHAR(10),
	@mancc CHAR(10)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @tongtien DECIMAL(18,2)
	SET @tongtien = 0
	DECLARE @MaPNH CHAR(10)
    SELECT TOP 1 @MAPNH = MaPNH FROM PHIEUNHAPHANG WHERE MAPNH LIKE 'PM%' AND NgayNhap IS NULL ORDER BY MaPNH ASC

    IF @MaPNH IS NULL
    BEGIN
        DECLARE @lASt_MaPNH CHAR(10)
        SELECT TOP 1 @lASt_MaPNH = MaPNH FROM PHIEUNHAPHANG WHERE MaPNH LIKE 'PM%' ORDER BY MaPNH DESC
        DECLARE @next_MaPNH INT
        SET @next_MaPNH = CAST(RIGHT(@lASt_MaPNH, 8) AS INT) + 1
        SET @MaPNH = 'PM' + RIGHT('00000000' + CAST(@next_MaPNH AS VARCHAR(8)), 8)
    END
	INSERT INTO PHIEUNHAPHANG(MaPNH, NgayNhap, TongTien, MaNV, MaNCC)
			VALUES (@MaPNH, @ngaynhap, @tongtien, @manv, @mancc);
			PRINT N'Thêm phiếu nhập hàng thành công';
END;

GO

--Store PROC xóa phiếu mua hàng
CREATE OR ALTER PROC sp_XoaPhieuNhapHang
	@mapmh CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM PHIEUNHAPHANG WHERE MaPNH = @mapmh)
		BEGIN
			DELETE FROM PHIEUNHAPHANG WHERE MaPNH = @mapmh;
			PRINT N'Xóa phiếu mua hàng thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy phiếu mua hàng có mã: %s.', 16, 1, @mapmh);   
END;

GO

--Store PROC cập nhật phiếu mua hàng
CREATE OR ALTER PROC sp_CapNhatPhieuNhapHang
    @mapmh CHAR(10),@ngaynhap DATE,
	@tongtien DECIMAL(18,2), @manv CHAR(10),
	@mancc CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM PHIEUNHAPHANG WHERE MaPNH = @mapmh)
		BEGIN
			UPDATE PHIEUNHAPHANG
			SET NgayNhap = @ngaynhap, TongTien = @tongtien, MaNV=@manv, MaNCC = @mancc
			WHERE MaPNH = @mapmh;
			PRINT N'Cập nhật phiếu mua hàng thành công';
		END;
    ELSE   
        RAISERROR(N'Không tìm thấy phiếu mua hàng có mã: %s.', 16, 1, @mapmh);   
END;

GO

--Store PROC tổng số lượng sản phẩm đã mua từ nhà cung cấp 
CREATE OR ALTER PROC sp_Tong_SoLuong_SanPham_DaMua
	@mancc CHAR(10)
AS
BEGIN
	SELECT SUM(ct.SoLuongNhap) AS TongSoSanPham
    FROM PHIEUNHAPHANG pm
	INNER JOIN CHITIET_PHIEUNHAP ct ON ct.MaPNH = pm.MaPNH
    WHERE pm.MaNCC = @mancc;
END;

GO

exec sp_Tong_SoLuong_SanPham_DaMua 'NCC0000006'
GO

--Store PROC tổng số lần mua hàng từ nhà cung cấp
CREATE OR ALTER PROC sp_Tong_SoLan_MuaHang
	@mancc CHAR(10)
AS
BEGIN
	SELECT COUNT(*) AS TongSoLanMuaHang
	FROM PHIEUNHAPHANG
	WHERE MaNCC = @mancc;
END;

GO

--Store PROC tìm kiếm chức vụ
CREATE OR ALTER PROC sp_TimKiem_ChucVu
	@tencv NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM dbo.fn_TimKiem_ChucVu(@tencv);
END;

GO

--Store PROC tìm kiếm phiếu mua hàng
CREATE OR ALTER PROC sp_TimKiem_PhieuMuaHang
	@mapmh CHAR(10)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM dbo.fn_TimKiem_PhieuMuaHang(@mapmh);
END;

GO

-- Thêm khách hàng
CREATE OR ALTER PROC sp_ThemKhachHang
    @hoten NVARCHAR(100),
    @sdt CHAR(11),@diachi NVARCHAR(200),
    @email CHAR(100),
    @ngaysinh CHAR(10),
    @gioitinh CHAR(1)
    
AS
BEGIN
    DECLARE @MAKH CHAR(10)
    SELECT TOP 1 @MAKH = MAKH FROM KHACHHANG WHERE MAKH LIKE 'KH%' AND hoten IS NULL ORDER BY MAKH ASC

    IF @MAKH IS NULL
    BEGIN
        DECLARE @lASt_makh CHAR(10)
        SELECT TOP 1 @lASt_makh = MAKH FROM KHACHHANG WHERE MAKH LIKE 'KH%' ORDER BY MAKH DESC
        DECLARE @next_makh INT
        SET @next_makh = CAST(RIGHT(@lASt_makh, 8) AS INT) + 1
        SET @MAKH = 'KH' + RIGHT('00000000' + CAST(@next_makh AS VARCHAR(8)), 8)
    END

   INSERT INTO KHACHHANG
				VALUES (@makh, @hoten, @sdt,@diachi, @email,@ngaysinh,@gioitinh)
END;

GO

CREATE OR ALTER PROC sp_UPDATEKhachHang
    @MaKH CHAR(10),
    @HoTen NVARCHAR(100),
    @SDT CHAR(11),
    @Email CHAR(100),
    @ngaysinh CHAR(10),
    @gioitinh CHAR(1),
    @DiaChi NVARCHAR(200)
AS
BEGIN
    UPDATE KHACHHANG
    SET HoTen = @HoTen,
        SDT = @SDT,
        Email = @Email,
        NgaySinh = @NgaySinh,
        GioiTinh = @GioiTinh,
        DiaChi = @DiaChi
    WHERE MaKH = @MaKH;
END

GO

-- Xóa Khách hàng
CREATE OR ALTER PROC sp_XoaKhachHang
    @MaKH CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM KHACHHANG WHERE MaKH = @MaKH;
END;

GO

-- Thêm Loại SP
CREATE OR ALTER PROC sp_ThemLoaiSP
	@tenloaisp NVARCHAR(100)
AS
BEGIN
	 DECLARE @MaLoaiSP CHAR(10)
    SELECT TOP 1 @MaLoaiSP = MaLoaiSP FROM LOAISANPHAM WHERE MaLoaiSP LIKE 'LSP%' AND TenLoaiSP IS NULL ORDER BY MaLoaiSP ASC

    IF @MaLoaiSP IS NULL
    BEGIN
        DECLARE @lASt_MaLoaiSP CHAR(10)
        SELECT TOP 1 @lASt_MaLoaiSP = MaLoaiSP FROM LOAISANPHAM WHERE MaLoaiSP LIKE 'LSP%' ORDER BY MaLoaiSP DESC
        DECLARE @next_MaLoaiSP INT
        SET @next_MaLoaiSP = CAST(RIGHT(@lASt_MaLoaiSP, 7) AS INT) + 1
        SET @MaLoaiSP = 'LSP' + RIGHT('0000000' + CAST(@next_MaLoaiSP AS VARCHAR(7)), 7)
    END

	INSERT INTO LOAISANPHAM VALUES (@maloaisp,@tenloaisp)
	
END

GO

-- Cập nhật Loại SP
CREATE OR ALTER PROC sp_UPDATELoaiSP
    @MaLoaiSP CHAR(10),
    @TenLoaiSP NVARCHAR(100)
AS
BEGIN
    UPDATE LOAISANPHAM
    SET TenLoaiSP = @TenLoaiSP
    WHERE MaLoaiSP = @MaLoaiSP;
END;

GO

CREATE OR ALTER PROC sp_TinhTongDoanhThuTheoThang
    @thang INT,
    @nam INT
AS
BEGIN
    DECLARE @tongtien DECIMAL

    SELECT @tongtien = dbo.fn_TinhTongDoanhThuTheoThang(@thang, @nam)

    SELECT @tongtien AS 'TongDoanhThu'
END

GO

CREATE OR ALTER PROC sp_TaoDonHang
	@makh CHAR(10),@manv CHAR(10)
AS
BEGIN
	DECLARE @ngaydat DATE, @pptt NVARCHAR(50), @ttdh INT, @tongtien DECIMAL
	SET @pptt = N'Tiền Mặt'
	SET @ttdh = 1
	SET @tongtien = 0
	SET @ngaydat = GETDATE()
	DECLARE @MaDH CHAR(10)
    SELECT TOP 1 @MADH = MaDH FROM DONHANG WHERE MADH LIKE 'DH%' AND MaKH IS NULL ORDER BY MADH ASC

    IF @MADH IS NULL
    BEGIN
        DECLARE @lASt_MADH CHAR(10)
        SELECT TOP 1 @lASt_MADH = MADH FROM DONHANG WHERE MADH LIKE 'DH%' ORDER BY MADH DESC
        DECLARE @next_MADH INT
        SET @next_MADH = CAST(RIGHT(@lASt_MADH, 8) AS INT) + 1
        SET @MADH = 'DH' + RIGHT('00000000' + CAST(@next_MADH AS VARCHAR(8)), 8)
    END

	INSERT INTO DONHANG VALUES (@MaDH,@ngaydat,@pptt,@ttdh,@tongtien,@makh,@manv)
END

GO

CREATE OR ALTER PROC sp_MuaHang
	@madh CHAR(10),
	@mASp CHAR(10),
	@soluong INT,
	@size FLOAT,
	@gioitinh CHAR(1)
AS
BEGIN
	DECLARE @soluongconlai INT
	SELECT @soluongconlai = SoLuong
	FROM KICHCO_SANPHAM
	WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)
	IF @soluongconlai >= @soluong
	BEGIN
		DECLARE @dongia NUMERIC(18,0) ,@tensp NVARCHAR(100), @giatien NUMERIC(18,0)
		
		
		SELECT @giatien= GiaBan FROM BIENDONGGIA WHERE MASP = @mASp
		SET @dongia = (SELECT GiaBan FROM BIENDONGGIA WHERE MASP = @mASp) * @soluong

		UPDATE DONHANG
		SET TongTien = TongTien + @dongia
		WHERE MaDH = @madh

		UPDATE KICHCO_SANPHAM
		SET SoLuong = Soluong - @soluong
		WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

		DECLARE @mASize CHAR(10)
		SELECT @mASize = MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh

		INSERT INTO CHITIET_DONHANG VALUES (@madh,@mASp,@mASize,@soluong, @giatien)
	END;
	ELSE
		BEGIN
			RAISERROR(N'Không đủ hàng', 16, 1)
		END;
	
END;

GO

CREATE OR ALTER PROC sp_UPDATEDonHang
	@madh CHAR(10),
	@trangthai INT
AS
BEGIN
	UPDATE DONHANG
	SET TrangThaiDH = @trangthai
	WHERE @madh = MaDH
END

GO

CREATE OR ALTER PROC sp_xoaCTDONHANG
	@mact CHAR(10),
	@mASp CHAR(10),
	@makc CHAR(10)
AS
BEGIN
	DELETE FROM CHITIET_DONHANG WHERE @mact = MaDH and MASP = @mASp and @makc = MaKC
END

GO

CREATE OR ALTER PROC sp_UPDATECTDONHANG_SoLuong
	@madh CHAR(10),
	@mASp CHAR(10),
	@soluong INT,
	@size FLOAT,
	@gioitinh CHAR(1)
AS
BEGIN

	DECLARE @tongtienhientai DECIMAL(18,0)
	SELECT @tongtienhientai = GiaTien *SoLuong
	FROM CHITIET_DONHANG


	DECLARE @soluonghientai INT
	SELECT @soluonghientai = SoLuong
	FROM CHITIET_DONHANG
	WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

	DECLARE @soluongconlai INT
	SELECT @soluongconlai = SoLuong
	FROM KICHCO_SANPHAM
	WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

	IF @soluongconlai >= @soluong
	BEGIN
		DECLARE @dongia NUMERIC(18,0) ,@giatien NUMERIC(18,0)
		SELECT @giatien= GiaBan FROM BIENDONGGIA WHERE MASP = @mASp
		SET @dongia = (SELECT GiaBan FROM BIENDONGGIA WHERE MASP = @mASp) * @soluong

		UPDATE DONHANG
		SET TongTien = TongTien - @tongtienhientai
		WHERE MaDH = @madh

		UPDATE DONHANG
		SET TongTien = TongTien + @dongia
		WHERE MaDH = @madh

		UPDATE KICHCO_SANPHAM
		SET SoLuong = Soluong + @soluonghientai
		WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

		UPDATE KICHCO_SANPHAM
		SET SoLuong = Soluong - @soluong
		WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

		DECLARE @mASize CHAR(10)
		SELECT @mASize = MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh

		UPDATE CHITIET_DONHANG
			SET	SoLuong = @soluong,
				GiaTien = @dongia
			WHERE @madh = MaDH and MASP = @mASp and MaKC = @mASize

	END;
	ELSE
		BEGIN
			RAISERROR(N'Không đủ hàng', 16, 1)
		END;
	
END

GO

CREATE OR ALTER PROC sp_TimKiem_KhachHang
(
    @tenkh NVARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM dbo.fn_TimKiem_KHACHHANG(@tenkh)
END;

GO

CREATE OR ALTER PROC sp_TimKiem_DONHANG
(
    @madh CHAR(10)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM dbo.fn_TimKiem_DONHANG(@madh)
END;

GO

CREATE OR ALTER PROC sp_NhapHang
	@mapnh CHAR(10),
	@mASp CHAR(10),
	@soluong INT,
	@size FLOAT,
	@gioitinh CHAR(1),
	@tinhtrang INT
AS
BEGIN

		DECLARE @dongia NUMERIC(18,0), @giatien NUMERIC(18,0)
		
		SELECT @giatien= GiaBan FROM BIENDONGGIA WHERE MASP = @mASp
		SET @dongia = (SELECT GiaBan FROM BIENDONGGIA WHERE MASP = @mASp) * @soluong

		UPDATE PHIEUNHAPHANG
		SET TongTien = TongTien + @dongia
		WHERE MaPNH = @mapnh

		UPDATE KICHCO_SANPHAM
		SET SoLuong = Soluong + @soluong
		WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

		DECLARE @mASize CHAR(10)
		SELECT @mASize = MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh

		INSERT INTO CHITIET_PHIEUNHAP VALUES (@mapnh,@mASp,@mASize,@soluong, @giatien,@tinhtrang)
	
END;

GO

CREATE OR ALTER PROC sp_UPDATECTPhieuNhap_SoLuong
	@mapnh CHAR(10),
	@mASp CHAR(10),
	@soluong INT,
	@size FLOAT,
	@gioitinh CHAR(1),
	@tinhtrang INT
AS
BEGIN

	DECLARE @tongtienhientai DECIMAL(18,0)
	SELECT @tongtienhientai = DonGiaNhap *SoLuongNhap
	FROM CHITIET_PHIEUNHAP


	DECLARE @soluonghientai INT
	SELECT @soluonghientai = SoLuongNhap
	FROM CHITIET_PHIEUNHAP
	WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

		DECLARE @dongia NUMERIC(18,0) ,@giatien NUMERIC(18,0)
		SELECT @giatien= GiaBan FROM BIENDONGGIA WHERE MASP = @mASp
		SET @dongia = (SELECT GiaBan FROM BIENDONGGIA WHERE MASP = @mASp) * @soluong

		UPDATE PHIEUNHAPHANG
		SET TongTien = TongTien - @tongtienhientai
		WHERE MaPNH = @mapnh

		UPDATE PHIEUNHAPHANG
		SET TongTien = TongTien + @dongia
		WHERE MaPNH = @mapnh

		UPDATE KICHCO_SANPHAM
		SET SoLuong = Soluong - @soluonghientai
		WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

		UPDATE KICHCO_SANPHAM
		SET SoLuong = Soluong + @soluong
		WHERE MASP = @mASp and MAKC = (SELECT MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh)

		DECLARE @mASize CHAR(10)
		SELECT @mASize = MaKC FROM KICHCO WHERE LoaiKichCo = @size and GioiTinh = @gioitinh

		UPDATE CHITIET_PHIEUNHAP
			SET	SoLuongNhap = @soluong,
				DonGiaNhap = @giatien
			WHERE @mapnh = MaPNH and MASP = @mASp and MaKC = @mASize
	
END