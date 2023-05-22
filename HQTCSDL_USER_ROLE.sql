USE fashionDatabase
GO
--------------------TẠO TÀI KHOẢN--------------------
CREATE LOGIN leduy WITH PASSWORD = '123';
GO

CREATE LOGIN tanhiep WITH PASSWORD = '123';
GO

CREATE LOGIN hoangkha WITH PASSWORD = '123';
GO

CREATE LOGIN thaiduy WITH PASSWORD = '123';
GO

CREATE LOGIN thanhdat WITH PASSWORD = '123';
GO

CREATE LOGIN nhathuy WITH PASSWORD = '123';
GO
--------------------TẠO NGƯỜI DÙNG--------------------
--Quản trị viên
CREATE USER u_Admin1 FOR LOGIN leduy;
GO

CREATE USER u_Admin2 FOR LOGIN hoangkha;
GO
--Quản lý
CREATE USER u_Manager1 FOR LOGIN tanhiep;
GO

CREATE USER u_Manager2 FOR LOGIN thaiduy;
GO
--Nhân viên

CREATE USER u_Employee2 FOR LOGIN thanhdat;
GO

CREATE USER u_Employee3 FOR LOGIN nhathuy;
GO
--------------------TẠO ROLE--------------------
CREATE ROLE r_QUANTRIVIEN;
GO

CREATE ROLE r_QUANLY_CUAHANG;
GO

CREATE ROLE r_NHANVIEN_BANHANG;
GO
--------------------GÁN QUYỀN CHO ROLE--------------------
----------Quản trị viên----------
--Gán toàn quyền cho role QUANTRIVIEN
--Dùng role db_owner có sẵn trong SQL SERVER
ALTER ROLE db_owner ADD MEMBER r_QUANTRIVIEN;
GO
----------Quản lý cửa hàng----------
--Bảng sản phẩm
GRANT SELECT, INSERT, UPDATE, DELETE ON SANPHAM TO r_QUANLY_CUAHANG;		
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON KICHCO TO r_QUANLY_CUAHANG;		
GO
GRANT SELECT ON KICHCO_SANPHAM TO r_QUANLY_CUAHANG;
GO
--Bảng nhà cung cấp
GRANT SELECT, INSERT, UPDATE ON NHACUNGCAP TO r_QUANLY_CUAHANG;
GO
--Bảng nhân viên
GRANT SELECT, INSERT, UPDATE, DELETE ON NHANVIEN TO r_QUANLY_CUAHANG;		
GO
--Bảng khách hàng
GRANT SELECT, INSERT, UPDATE, DELETE ON KHACHHANG TO r_QUANLY_CUAHANG;	
GO
--Bảng Biến động giá
GRANT SELECT, INSERT, UPDATE, DELETE ON BIENDONGGIA TO r_QUANLY_CUAHANG;
GO
--Bảng đơn hàng
GRANT SELECT, INSERT ON DONHANG TO r_QUANLY_CUAHANG;		
GO
GRANT UPDATE(TrangThaiDH) ON DONHANG TO r_QUANLY_CUAHANG
GO
--Bảng chi tiết đơn hàng
GRANT SELECT ON CHITIET_DONHANG TO r_QUANLY_CUAHANG;
GO
GRANT UPDATE(SoLuong) ON CHITIET_DONHANG TO r_QUANLY_CUAHANG;
GO
--Bảng phiêu nhập hàng
GRANT SELECT, INSERT, UPDATE, DELETE ON PHIEUNHAP TO r_QUANLY_CUAHANG;
GO
GRANT SELECT, INSERT, UPDATE(SoLuongNhap, DonGiaNhap, TinhTrang) ON CHITIET_PHIEUNHAP TO r_QUANLY_CUAHANG;
GO
----------Nhân viên bán hàng----------
--Bảng sản phẩm
GRANT SELECT, INSERT, UPDATE ON SANPHAM TO r_NHANVIEN_BANHANG;			
GO
GRANT SELECT, INSERT, UPDATE ON KICHCO TO r_NHANVIEN_BANHANG;			
GO
GRANT SELECT ON KICHCO_SANPHAM TO r_NHANVIEN_BANHANG;
GO
--Bảng khách hàng
GRANT SELECT, INSERT ON KHACHHANG TO r_NHANVIEN_BANHANG;					
GO
--Bảng đơn hàng
GRANT SELECT, INSERT, UPDATE(TrangThaiDH) ON DONHANG TO r_NHANVIEN_BANHANG;			
GO
--------------------CẤP QUYỀN CHO NGƯỜI DÙNG--------------------
--Quyền quản trị 
ALTER ROLE r_QUANTRIVIEN ADD MEMBER u_Admin1;
GO

ALTER ROLE r_QUANTRIVIEN ADD MEMBER u_Admin2;
GO
--Quyền quản lý
ALTER ROLE r_QUANLY_CUAHANG ADD MEMBER u_Manager1;
GO

ALTER ROLE r_QUANLY_CUAHANG ADD MEMBER u_Manager2;
GO
--Quyền nhân viên

ALTER ROLE r_NHANVIEN_BANHANG ADD MEMBER u_Employee2;
GO

ALTER ROLE r_NHANVIEN_BANHANG ADD MEMBER u_Employee3;
GO

--Nếu muốn dùng user nào chạy lệnh query thì dùng cú pháp
--EXEC AS USER = '<user_name>'
--GO