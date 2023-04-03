<<<<<<< HEAD
USE master
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'shoestoreDB')
BEGIN
	DROP DATABASE shoestoreDB
END

CREATE DATABASE shoestoreDB
GO

USE shoestoreDB
GO


CREATE TABLE USERS
(
  username CHAR(32) NOT NULL,
  password CHAR(16) NOT NULL,
  role CHAR(2) NOT NULL,
  PRIMARY KEY (username)
);

CREATE TABLE PHONGBAN
(
  MaPB CHAR(5) NOT NULL,
  TenPB VARCHAR(30) NOT NULL,
  PRIMARY KEY (MaPB)
);

CREATE TABLE CHUCVU
(
  MaCV CHAR(10) NOT NULL,
  TenCV VARCHAR(50) NOT NULL,
  PRIMARY KEY (MaCV)
);

CREATE TABLE PHANLOAIKHACHHANG
(
  MaLoaiKH CHAR(5) NOT NULL,
  TenLoai VARCHAR(100) NOT NULL,
  PRIMARY KEY (MaLoaiKH)
);

CREATE TABLE KHACHHANG
(
  MaKH CHAR(10) NOT NULL,
  HoKH VARCHAR(10) NOT NULL,
  HoLotKH VARCHAR(30) NOT NULL,
  TenKH VARCHAR(10) NOT NULL,
  username CHAR(32) NOT NULL,
  MaLoaiKH CHAR(5) NOT NULL,
  CMND NUMERIC(12,0) NOT NULL,
  PRIMARY KEY (MaKH),
  FOREIGN KEY (username) REFERENCES USERS(username),
  FOREIGN KEY (MaLoaiKH) REFERENCES PHANLOAIKHACHHANG(MaLoaiKH),
);

CREATE TABLE CHITIETKHACHHANG
(
  MaKH CHAR(10) NOT NULL,
  emailKH CHAR(100) NOT NULL, 
  DiaChi VARCHAR(100) NOT NULL,
  GioiTinh CHAR(10) NOT NULL,
  SDT NUMERIC(11,0) NOT NULL,
  PRIMARY KEY (MaKH),
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
);

CREATE TABLE NHANVIEN
(
  MaNV CHAR(10) NOT NULL,
  HoNV VARCHAR(10) NOT NULL,
  HoLotNV VARCHAR(30) NOT NULL,
  TenNV VARCHAR(10) NOT NULL,
  username CHAR(32) NOT NULL,
  MaCV CHAR(10) NOT NULL,
  MaPB CHAR(5) NOT NULL,
  CMND NUMERIC(12,0) NOT NULL,
  PRIMARY KEY (MaNV),
  FOREIGN KEY (username) REFERENCES USERS(username),
  FOREIGN KEY (MaCV) REFERENCES CHUCVU(MaCV),
  FOREIGN KEY (MaPB) REFERENCES PHONGBAN(MaPB)
);

CREATE TABLE CHITIETNHANVIEN
(
  MaNV CHAR(10) NOT NULL,
  emailNV CHAR(100) NOT NULL, 
  DiaChi VARCHAR(100) NOT NULL,
  GioiTinh CHAR(10) NOT NULL,
  SDT NUMERIC(11,0) NOT NULL,
  PRIMARY KEY (MaNV),
  FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

CREATE TABLE NHACUNGCAP
(
  MaNCC CHAR(10) NOT NULL,
  TenNCC VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaNCC)
);

CREATE TABLE LOAISANPHAM
(
  MaLoaiSP CHAR(5) NOT NULL,
  TenLoaiSP VARCHAR(50) NOT NULL,
  PRIMARY KEY (MaLoaiSP)
);

CREATE TABLE SANPHAM
(
  MaSP CHAR(10) NOT NULL,
  TenSP VARCHAR(50) NOT NULL,
  MaLoaiSP CHAR(5) NOT NULL,
  MaNCC CHAR(10) NOT NULL,
  PRIMARY KEY (MaSP),
  FOREIGN KEY (MaLoaiSP) REFERENCES LOAISANPHAM(MaLoaiSP),
  FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC)
);

CREATE TABLE CHITIETSANPHAM
(
  MaCTSP CHAR(10) NOT NULL,
  MaSP CHAR(10) NOT NULL,
  GiaSP INT NOT NULL,
  Size INT NOT NULL,
  TinhTrangSP VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaCTSP),
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);

CREATE TABLE MATHANGNCC
(
  MaSP CHAR(10) NOT NULL,
  MaNCC CHAR(10) NOT NULL,
  SoLuong INT NOT NULL,
  Size INT NOT NULL,
  PRIMARY KEY (MaSP, MaNCC,Size),
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);


CREATE TABLE DONHANG
(
  MaDH CHAR(10) NOT NULL,
  NgayDatHang DATE NOT NULL,
  NgayGiaoHang DATE NOT NULL,
  PTThanhToan VARCHAR(20) NOT NULL,
  TrangThaiDH VARCHAR(50) NOT NULL,
  TongTien INT NOT NULL,
  MaKH CHAR(10) NOT NULL,
  MaNV CHAR(10) NOT NULL,
  PRIMARY KEY (MaDH),
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
  FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

CREATE TABLE CTDONHANG
(
  MaDH CHAR(10) NOT NULL,
  MaSP CHAR(10) NOT NULL,
  SoLuongDat INT NOT NULL,
  Size INT NOT NULL,
  DonGia INT NOT NULL,
  PRIMARY KEY (MaDH, MaSP),
  FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH),
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);

CREATE TABLE LOAIHOADON
(
  MaLoaiHD CHAR(10) NOT NULL,
  TenLoaiHD VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaLoaiHD)
);

CREATE TABLE HOADON
(
  MaHD CHAR(10) NOT NULL,
  NgayLap DATE NOT NULL,
  TongTien INT NOT NULL,
  MaKH CHAR(10) NOT NULL,
  MaDH CHAR(10) NOT NULL,
  MaNV CHAR(10) NOT NULL,
  MaLoaiHD CHAR(10) NOT NULL,
  PRIMARY KEY (MaHD),
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
  FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH),
  FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
  FOREIGN KEY (MaLoaiHD) REFERENCES LOAIHOADON(MaLoaiHD)
);

CREATE TABLE TONKHO
(
  MaSP CHAR(10) NOT NULL,
  Thang FLOAT NOT NULL,
  Nam FLOAT NOT NULL,
  TonDK FLOAT NOT NULL,
  TonCK FLOAT NOT NULL,
  NhapTK FLOAT NOT NULL,
  XuatTK FLOAT NOT NULL,
  PRIMARY KEY (MaSP, Thang, Nam),
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);

CREATE TABLE PHIEUXUAT
(
  MaPX CHAR(10) NOT NULL,
  NgayXuat DATE NOT NULL,
  LyDo VARCHAR(100) NOT NULL,
  PRIMARY KEY (MaPX)
);

CREATE TABLE CTPHIEUXUAT
(
  MaPX CHAR(10) NOT NULL,
  MaSP CHAR(10) NOT NULL,
  SoLuongXuat FLOAT NOT NULL,
  DonGiaXuat INT NOT NULL,
  PRIMARY KEY (MaPX, MaSP),
  FOREIGN KEY (MaPX) REFERENCES PHIEUXUAT(MaPX),
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into PHANLOAIKHACHHANG (MaLoaiKH, TenLoai) values ('KHTV', N'Khách hàng thành viên');
insert into PHANLOAIKHACHHANG (MaLoaiKH, TenLoai) values ('KHTT', N'Khách hàng thân thiết');
insert into PHANLOAIKHACHHANG (MaLoaiKH, TenLoai) values ('KHVIP', N'Khách hàng vip');
insert into PHANLOAIKHACHHANG (MaLoaiKH, TenLoai) values ('KHTC', N'Khách hàng tiêu cực');

select * from PHANLOAIKHACHHANG
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into USERS (username, password, role) values ('fjenks0', '123', 'KH');
insert into USERS (username, password, role) values ('gnosworthy1', '123', 'KH');
insert into USERS (username, password, role) values ('kdooler2', '123', 'KH');
insert into USERS (username, password, role) values ('wbelcham3', '123', 'KH');
insert into USERS (username, password, role) values ('wwillowby4', '123', 'KH');
insert into USERS (username, password, role) values ('abeynke5', '123', 'KH');
insert into USERS (username, password, role) values ('dseary6', '123', 'KH');
insert into USERS (username, password, role) values ('hovize7', '123', 'KH');
insert into USERS (username, password, role) values ('hcastanho8', '123', 'KH');
insert into USERS (username, password, role) values ('dphateplace9', '123', 'KH');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into USERS (username, password, role) values ('dparkeson0', '456', 'NV');
insert into USERS (username, password, role) values ('acarnegy1', '456', 'NV');
insert into USERS (username, password, role) values ('iclemenzi2', '456', 'NV');
insert into USERS (username, password, role) values ('cmartino3', '456', 'NV');
insert into USERS (username, password, role) values ('rrand4', '456', 'NV');
insert into USERS (username, password, role) values ('rwiggall5', '456', 'NV');
insert into USERS (username, password, role) values ('dcordeix6', '456', 'NV');
insert into USERS (username, password, role) values ('aszymonowicz7', '456', 'NV');
insert into USERS (username, password, role) values ('tcharley8', '456', 'NV');
insert into USERS (username, password, role) values ('efigger9', '456', 'NV');
insert into USERS (username, password, role) values ('govittsa', '456', 'NV');
insert into USERS (username, password, role) values ('wganforthb', '456', 'NV');
insert into USERS (username, password, role) values ('rmaciociac', '456', 'NV');
insert into USERS (username, password, role) values ('twimpd', '789', 'AD');
insert into USERS (username, password, role) values ('jspentone', '789', 'AD');

select * from USERS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH01','Jenni', 'Jenks', 'Frannie', 'fjenks0', 'KHTV', 079202034605);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH02', 'Claudie', 'Nosworthy', 'Gregory', 'gnosworthy1', 'KHTV', 079202034609);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH03', 'Gunther', 'Dooler', 'Kiri', 'kdooler2', 'KHTV', 079202034856);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH04', 'Brina', 'Belcham', 'Winni', 'wbelcham3', 'KHTT', 079202035862);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH05', 'Ronnie', 'Willowby', 'Wynne', 'wwillowby4', 'KHTT', 079202034210);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH06', 'Clark', 'Beynke', 'Adela', 'abeynke5', 'KHTT', 079202039863);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH07', 'Mufinella', 'Seary', 'Dewain', 'dseary6', 'KHTT', 079202009876);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH08', 'Arri', 'Ovize', 'Hi', 'hovize7', 'KHTT', 079202034123);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH09', 'Della', 'Castanho', 'Hermione', 'hcastanho8', 'KHVIP', 079202034456);
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH10', 'Enid', 'Phateplace', 'Dall', 'dphateplace9', 'KHTC', 079202034789);

select * from KHACHHANG
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from CHITIETKHACHHANG

insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH01', 'fjenks0@gmail.com', '85 Dexter Place', 'Male', 0972656723);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH02', 'gnosworthy1@gmail.com', '08522 Elmside Hill', 'Female', 0979264233);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH03', 'kdooler2@gmail.com', '1 Hagan Lane', 'Female', 0979483749);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH04', 'wbelcham3@gmail.com', '87 Park Meadow Court', 'Male', 0977205613);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH05', 'wwillowby4@gmail.com', '9 Killdeer Terrace', 'Female', 0975557385);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH06', 'abeynke5@gmail.com', '70077 Buhler Trail', 'Male', 0962330351);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH07', 'dseary6@gmail.com', '8943 American Terrace', 'Male', 0961818970);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH08', 'hovize7@gmail.com', '74570 Pankratz Junction', 'Male', 0967594384);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH09', 'hcastanho8@gmail.com', '4 Continental Way', 'Male', 0967178523);
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH10', 'dphateplace9@gmail.com', '6 Center Point', 'Male', 0962664283);

select * from CHITIETKHACHHANG
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into PHONGBAN (MaPB, TenPB) values ('BGD', N'Ban giám đốc');
insert into PHONGBAN (MaPB, TenPB) values ('CSKH', N'Chăm sóc khách hàng');
insert into PHONGBAN (MaPB, TenPB) values ('BH', N'Bộ phận bán hàng');
insert into PHONGBAN (MaPB, TenPB) values ('TK', N'Bộ phận quản lý hàng tồn');

select * from PHONGBAN
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into CHUCVU (MaCV, TenCV) values ('GD', N'Giám đốc');
insert into CHUCVU (MaCV, TenCV) values ('PGD', N'Phó giám đốc');
insert into CHUCVU (MaCV, TenCV) values ('NVBH', N'Nhân viên bán hàng');
insert into CHUCVU (MaCV, TenCV) values ('TPBH', N'Trường phòng bán hàng');
insert into CHUCVU (MaCV, TenCV) values ('QLBH', N'Quản lý bán hàng');
insert into CHUCVU (MaCV, TenCV) values ('TPKHO', N'Trưởng phòng kho hàng');
insert into CHUCVU (MaCV, TenCV) values ('NVKHO', N'Nhân viên kho hàng');
insert into CHUCVU (MaCV, TenCV) values ('QLKHO', N'Quản lý kho hàng');
insert into CHUCVU (MaCV, TenCV) values ('TPCSKH', N'Trưởng phòng CSKH');
insert into CHUCVU (MaCV, TenCV) values ('NVCSKH', N'Nhân viên CSKH');

select * from CHUCVU
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into LOAIHOADON (MaLoaiHD, TenLoaiHD) values ('HDBH', N'Hóa đơn bán hàng');
insert into LOAIHOADON (MaLoaiHD, TenLoaiHD) values ('GTGT', N'Giá trị gia tăng');

select * from LOAIHOADON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV01', 'Arpino', 'Lyffe', 'Napoleon', 'dparkeson0', 'NVBH', 'BH', 077202081605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV02', 'Oxtoby', 'MacAlaster', 'Jacinda', 'acarnegy1', 'NVBH', 'BH', 077202069605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV03', 'Heady', 'Ferrick', 'Vincenz', 'iclemenzi2', 'NVBH', 'BH', 077202049605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV04', 'Roxby', 'Szepe', 'Messimili', 'cmartino3', 'NVKHO', 'TK', 077505034605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV05', 'Swindell', 'Cutchee', 'Alphonso', 'rrand4', 'NVKHO', 'TK', 077200034605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV06', 'Tremble', 'Garham', 'Avictor', 'rwiggall5', 'NVKHO', 'TK', 077222034605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV07', 'Dunican', 'Janos', 'Sunshine', 'dcordeix6', 'NVCSKH', 'CSKH', 077112034605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV08', 'Parell', 'Clemas', 'Merrick', 'aszymonowicz7', 'NVCSKH', 'CSKH', 077303034605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV09', 'Stother', 'Manser', 'Hyacinthie', 'tcharley8', 'TPCSKH', 'CSKH', 077202123605);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV10', 'Keepence', 'Carvell', 'Giulietta', 'efigger9', 'QLKHO', 'TK', 077202034127);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV11', 'Gigg', 'Skatcher', 'Freida', 'govittsa', 'TPKHO', 'TK', 077202034125);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV12', 'Evert', 'Medcalfe', 'Gloriane', 'wganforthb', 'QLBH', 'BH', 077202034124);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV13', 'Sagerson', 'McVane', 'Rosabella', 'rmaciociac', 'TPBH', 'BH', 077202034789);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('GIAMDOC', 'Rieme', 'Ferrar', 'Jemie', 'twimpd', 'GD', 'BGD', 077202034456);
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('PGIAMDOC', 'Hadleigh', 'Faragher', 'Palm', 'jspentone', 'PGD', 'BGD', 077202034123);

select * from NHANVIEN
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV01', 'dparkeson0@gmail.com', '4 Carberry Circle', 'Male', 0763913058);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV02', 'acarnegy1@gmail.com', '415 Oak Trail', 'Male', 0763987265);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV03', 'iclemenzi2@gmail.com', '8394 Pond Drive', 'Male', 0765751581);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV04', 'cmartino3@gmail.com', '76903 Surrey Circle', 'Male', 0765889141);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV05', 'rrand4@gmail.com', '788 Oneill Hill', 'Female', 0936748631);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV06', 'rwiggall5@gmail.com', '9 Delaware Parkway', 'Female', 0933663517);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV07', 'dcordeix6@gmail.com', '8 Westerfield Plaza', 'Male', 0931158222);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV08', 'aszymonowicz7@gmail.com', '12 Delaware Place', 'Female', 0933306413);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV09', 'tcharley8@gmail.com', '91765 Coolidge Parkway', 'Female', 0933998611);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV10', 'efigger9@gmail.com', '94375 Eastwood Junction', 'Female', 0938745922);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV11', 'govittsa@gmail.com', '456 Mcguire Parkway', 'Male', 0911481113);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV12', 'wganforthb@gmail.com', '759 Lakewood Parkway', 'Female', 0912379143);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV13', 'rmaciociac@gmail.com', '7655 Michigan Center', 'Male', 0911292683);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('GIAMDOC', 'twimpd@gmail.com', '5173 Summit Point', 'Male', 0914824907);
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('PGIAMDOC', 'jspentone@gmail.com', '1749 Ridge Oak Way', 'Female', 0917391047);

select * from CHITIETNHANVIEN
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
=======
﻿USE master 
GO 
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'shoestoreDB') 
BEGIN 
	DROP DATABASE shoestoreDB 
END 
 
CREATE DATABASE shoestoreDB 
GO 
 
USE shoestoreDB 
GO 
 
 
CREATE TABLE USERS 
( 
  username CHAR(32) NOT NULL, 
  password CHAR(16) NOT NULL, 
  role CHAR(2) NOT NULL, 
  PRIMARY KEY (username) 
); 
 
CREATE TABLE PHONGBAN 
( 
  MaPB CHAR(5) NOT NULL, 
  TenPB VARCHAR(30) NOT NULL, 
  PRIMARY KEY (MaPB) 
); 
 
CREATE TABLE CHUCVU 
( 
  MaCV CHAR(10) NOT NULL, 
  TenCV VARCHAR(50) NOT NULL, 
  PRIMARY KEY (MaCV) 
); 
 
CREATE TABLE PHANLOAIKHACHHANG 
( 
  MaLoaiKH CHAR(5) NOT NULL, 
  TenLoai VARCHAR(100) NOT NULL, 
  PRIMARY KEY (MaLoaiKH) 
); 
 
CREATE TABLE KHACHHANG 
( 
  MaKH CHAR(10) NOT NULL, 
  HoKH VARCHAR(10) NOT NULL, 
  HoLotKH VARCHAR(30) NOT NULL, 
  TenKH VARCHAR(10) NOT NULL, 
  username CHAR(32) NOT NULL, 
  MaLoaiKH CHAR(5) NOT NULL, 
  CMND NUMERIC(12,0) NOT NULL, 
  PRIMARY KEY (MaKH), 
  FOREIGN KEY (username) REFERENCES USERS(username), 
  FOREIGN KEY (MaLoaiKH) REFERENCES PHANLOAIKHACHHANG(MaLoaiKH), 
); 
 
CREATE TABLE CHITIETKHACHHANG 
( 
  MaKH CHAR(10) NOT NULL, 
  emailKH CHAR(100) NOT NULL,  
  DiaChi VARCHAR(100) NOT NULL, 
  GioiTinh CHAR(10) NOT NULL, 
  SDT NUMERIC(11,0) NOT NULL, 
  PRIMARY KEY (MaKH), 
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH) 
); 
 
CREATE TABLE NHANVIEN 
( 
  MaNV CHAR(10) NOT NULL, 
  HoNV VARCHAR(10) NOT NULL, 
  HoLotNV VARCHAR(30) NOT NULL, 
  TenNV VARCHAR(10) NOT NULL, 
  username CHAR(32) NOT NULL, 
  MaCV CHAR(10) NOT NULL, 
  MaPB CHAR(5) NOT NULL, 
  CMND NUMERIC(12,0) NOT NULL, 
  PRIMARY KEY (MaNV), 
  FOREIGN KEY (username) REFERENCES USERS(username), 
  FOREIGN KEY (MaCV) REFERENCES CHUCVU(MaCV), 
  FOREIGN KEY (MaPB) REFERENCES PHONGBAN(MaPB) 
); 
 
CREATE TABLE CHITIETNHANVIEN 
( 
  MaNV CHAR(10) NOT NULL, 
  emailNV CHAR(100) NOT NULL,  
  DiaChi VARCHAR(100) NOT NULL, 
  GioiTinh CHAR(10) NOT NULL, 
  SDT NUMERIC(11,0) NOT NULL, 
  PRIMARY KEY (MaNV), 
  FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV) 
); 
 
CREATE TABLE NHACUNGCAP 
( 
  MaNCC CHAR(10) NOT NULL, 
  TenNCC VARCHAR(20) NOT NULL, 
  PRIMARY KEY (MaNCC) 
); 
 
CREATE TABLE LOAISANPHAM 
( 
  MaLoaiSP CHAR(5) NOT NULL, 
  TenLoaiSP VARCHAR(50) NOT NULL, 
  PRIMARY KEY (MaLoaiSP) 
); 
 
CREATE TABLE SANPHAM 
( 
  MaSP CHAR(10) NOT NULL, 
  TenSP VARCHAR(50) NOT NULL, 
  MaLoaiSP CHAR(5) NOT NULL, 
  MaNCC CHAR(10) NOT NULL, 
  PRIMARY KEY (MaSP), 
  FOREIGN KEY (MaLoaiSP) REFERENCES LOAISANPHAM(MaLoaiSP), 
  FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC) 
); 
 
CREATE TABLE CHITIETSANPHAM 
( 
  MaCTSP CHAR(10) NOT NULL, 
  MaSP CHAR(10) NOT NULL, 
  GiaSP INT NOT NULL, 
  Size INT NOT NULL, 
  TinhTrangSP VARCHAR(20) NOT NULL, 
  PRIMARY KEY (MaCTSP), 
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP) 
); 
 
CREATE TABLE MATHANGNCC 
( 
  MaSP CHAR(10) NOT NULL, 
  MaNCC CHAR(10) NOT NULL, 
  SoLuong INT NOT NULL, 
  Size INT NOT NULL, 
  PRIMARY KEY (MaSP, MaNCC,Size), 
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP) 
); 
 
 
CREATE TABLE DONHANG 
( 
  MaDH CHAR(10) NOT NULL, 
  NgayDatHang DATE NOT NULL, 
  NgayGiaoHang DATE NOT NULL, 
  PTThanhToan VARCHAR(20) NOT NULL, 
  TrangThaiDH VARCHAR(50) NOT NULL, 
  TongTien INT NOT NULL, 
  MaKH CHAR(10) NOT NULL, 
  MaNV CHAR(10) NOT NULL, 
  PRIMARY KEY (MaDH), 
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH), 
  FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV) 
); 
 
CREATE TABLE CTDONHANG 
( 
  MaDH CHAR(10) NOT NULL, 
  MaSP CHAR(10) NOT NULL, 
  SoLuongDat INT NOT NULL, 
  Size INT NOT NULL, 
  DonGia INT NOT NULL, 
  PRIMARY KEY (MaDH, MaSP), 
  FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH), 
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP) 
); 
 
CREATE TABLE LOAIHOADON 
( 
  MaLoaiHD CHAR(10) NOT NULL, 
  TenLoaiHD VARCHAR(20) NOT NULL, 
  PRIMARY KEY (MaLoaiHD) 
); 
 
CREATE TABLE HOADON 
( 
  MaHD CHAR(10) NOT NULL, 
  NgayLap DATE NOT NULL, 
  TongTien INT NOT NULL, 
  MaKH CHAR(10) NOT NULL, 
  MaDH CHAR(10) NOT NULL, 
  MaNV CHAR(10) NOT NULL, 
  MaLoaiHD CHAR(10) NOT NULL, 
  PRIMARY KEY (MaHD), 
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH), 
  FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH), 
  FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV), 
  FOREIGN KEY (MaLoaiHD) REFERENCES LOAIHOADON(MaLoaiHD) 
); 
 
CREATE TABLE TONKHO 
( 
  MaSP CHAR(10) NOT NULL, 
  Thang FLOAT NOT NULL, 
  Nam FLOAT NOT NULL, 
  TonDK FLOAT NOT NULL, 
  TonCK FLOAT NOT NULL, 
  NhapTK FLOAT NOT NULL, 
  XuatTK FLOAT NOT NULL, 
  PRIMARY KEY (MaSP, Thang, Nam), 
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP) 
); 
 
CREATE TABLE PHIEUXUAT 
( 
  MaPX CHAR(10) NOT NULL, 
  NgayXuat DATE NOT NULL, 
  LyDo VARCHAR(100) NOT NULL, 
  PRIMARY KEY (MaPX) 
); 
 drop table CTPHIEUXUAT
CREATE TABLE CTPHIEUXUAT 
( 
  MaPX CHAR(10) NOT NULL, 
  MaSP CHAR(10) NOT NULL, 
  SoLuongXuat FLOAT NOT NULL, 
  DonGiaXuat INT NOT NULL, 
  PRIMARY KEY (MaPX, MaSP), 
  FOREIGN KEY (MaPX) REFERENCES PHIEUXUAT(MaPX), 
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP) 
); 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into PHANLOAIKHACHHANG (MaLoaiKH, TenLoai) values ('KHTV', N'Khách hàng thành viên'); 
insert into PHANLOAIKHACHHANG (MaLoaiKH, TenLoai) values ('KHTT', N'Khách hàng thân thiết'); 
insert into PHANLOAIKHACHHANG (MaLoaiKH, TenLoai) values ('KHVIP', N'Khách hàng vip'); 
insert into PHANLOAIKHACHHANG (MaLoaiKH, TenLoai) values ('KHTC', N'Khách hàng tiêu cực'); 
 
select * from PHANLOAIKHACHHANG 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into USERS (username, password, role) values ('fjenks0', '123', 'KH'); 
insert into USERS (username, password, role) values ('gnosworthy1', '123', 'KH'); 
insert into USERS (username, password, role) values ('kdooler2', '123', 'KH'); 
insert into USERS (username, password, role) values ('wbelcham3', '123', 'KH'); 
insert into USERS (username, password, role) values ('wwillowby4', '123', 'KH'); 
insert into USERS (username, password, role) values ('abeynke5', '123', 'KH'); 
insert into USERS (username, password, role) values ('dseary6', '123', 'KH'); 
insert into USERS (username, password, role) values ('hovize7', '123', 'KH'); 
insert into USERS (username, password, role) values ('hcastanho8', '123', 'KH'); 
insert into USERS (username, password, role) values ('dphateplace9', '123', 'KH'); 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into USERS (username, password, role) values ('dparkeson0', '456', 'NV'); 
insert into USERS (username, password, role) values ('acarnegy1', '456', 'NV'); 
insert into USERS (username, password, role) values ('iclemenzi2', '456', 'NV'); 
insert into USERS (username, password, role) values ('cmartino3', '456', 'NV'); 
insert into USERS (username, password, role) values ('rrand4', '456', 'NV'); 
insert into USERS (username, password, role) values ('rwiggall5', '456', 'NV'); 
insert into USERS (username, password, role) values ('dcordeix6', '456', 'NV'); 
insert into USERS (username, password, role) values ('aszymonowicz7', '456', 'NV'); 
insert into USERS (username, password, role) values ('tcharley8', '456', 'NV'); 
insert into USERS (username, password, role) values ('efigger9', '456', 'NV'); 
insert into USERS (username, password, role) values ('govittsa', '456', 'NV'); 
insert into USERS (username, password, role) values ('wganforthb', '456', 'NV'); 
insert into USERS (username, password, role) values ('rmaciociac', '456', 'NV'); 
insert into USERS (username, password, role) values ('twimpd', '789', 'AD'); 
insert into USERS (username, password, role) values ('jspentone', '789', 'AD'); 
 
select * from USERS 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH01','Jenni', 'Jenks', 'Frannie', 'fjenks0', 'KHTV', 079202034605); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH02', 'Claudie', 'Nosworthy', 'Gregory', 'gnosworthy1', 'KHTV', 079202034609); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH03', 'Gunther', 'Dooler', 'Kiri', 'kdooler2', 'KHTV', 079202034856); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH04', 'Brina', 'Belcham', 'Winni', 'wbelcham3', 'KHTT', 079202035862); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH05', 'Ronnie', 'Willowby', 'Wynne', 'wwillowby4', 'KHTT', 079202034210); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH06', 'Clark', 'Beynke', 'Adela', 'abeynke5', 'KHTT', 079202039863); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH07', 'Mufinella', 'Seary', 'Dewain', 'dseary6', 'KHTT', 079202009876); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH08', 'Arri', 'Ovize', 'Hi', 'hovize7', 'KHTT', 079202034123); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH09', 'Della', 'Castanho', 'Hermione', 'hcastanho8', 'KHVIP', 079202034456); 
insert into KHACHHANG (MaKH, HoKH, HoLotKH, TenKH, username, MaLoaiKH, CMND) values ('KH10', 'Enid', 'Phateplace', 'Dall', 'dphateplace9', 'KHTC', 079202034789); 
 
select * from KHACHHANG 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
select * from CHITIETKHACHHANG 
 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH01', 'fjenks0@gmail.com', '85 Dexter Place', 'Male', 0972656723); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH02', 'gnosworthy1@gmail.com', '08522 Elmside Hill', 'Female', 0979264233); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH03', 'kdooler2@gmail.com', '1 Hagan Lane', 'Female', 0979483749); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH04', 'wbelcham3@gmail.com', '87 Park Meadow Court', 'Male', 0977205613); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH05', 'wwillowby4@gmail.com', '9 Killdeer Terrace', 'Female', 0975557385); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH06', 'abeynke5@gmail.com', '70077 Buhler Trail', 'Male', 0962330351); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH07', 'dseary6@gmail.com', '8943 American Terrace', 'Male', 0961818970); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH08', 'hovize7@gmail.com', '74570 Pankratz Junction', 'Male', 0967594384); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH09', 'hcastanho8@gmail.com', '4 Continental Way', 'Male', 0967178523); 
insert into CHITIETKHACHHANG (MaKH, emailKH, DiaChi, GioiTinh, SDT) values ('KH10', 'dphateplace9@gmail.com', '6 Center Point', 'Male', 0962664283); 
 
select * from CHITIETKHACHHANG 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into PHONGBAN (MaPB, TenPB) values ('BGD', N'Ban giám đốc'); 
insert into PHONGBAN (MaPB, TenPB) values ('CSKH', N'Chăm sóc khách hàng'); 
insert into PHONGBAN (MaPB, TenPB) values ('BH', N'Bộ phận bán hàng'); 
insert into PHONGBAN (MaPB, TenPB) values ('TK', N'Bộ phận quản lý hàng tồn'); 
 
select * from PHONGBAN 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into CHUCVU (MaCV, TenCV) values ('GD', N'Giám đốc'); 
insert into CHUCVU (MaCV, TenCV) values ('PGD', N'Phó giám đốc'); 
insert into CHUCVU (MaCV, TenCV) values ('NVBH', N'Nhân viên bán hàng'); 
insert into CHUCVU (MaCV, TenCV) values ('TPBH', N'Trường phòng bán hàng'); 
insert into CHUCVU (MaCV, TenCV) values ('QLBH', N'Quản lý bán hàng'); 
insert into CHUCVU (MaCV, TenCV) values ('TPKHO', N'Trưởng phòng kho hàng'); 
insert into CHUCVU (MaCV, TenCV) values ('NVKHO', N'Nhân viên kho hàng'); 
insert into CHUCVU (MaCV, TenCV) values ('QLKHO', N'Quản lý kho hàng'); 
insert into CHUCVU (MaCV, TenCV) values ('TPCSKH', N'Trưởng phòng CSKH'); 
insert into CHUCVU (MaCV, TenCV) values ('NVCSKH', N'Nhân viên CSKH'); 
 
select * from CHUCVU 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into LOAIHOADON (MaLoaiHD, TenLoaiHD) values ('HDBH', N'Hóa đơn bán hàng'); 
insert into LOAIHOADON (MaLoaiHD, TenLoaiHD) values ('GTGT', N'Giá trị gia tăng'); 
 
select * from LOAIHOADON 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV01', 'Arpino', 'Lyffe', 'Napoleon', 'dparkeson0', 'NVBH', 'BH', 077202081605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV02', 'Oxtoby', 'MacAlaster', 'Jacinda', 'acarnegy1', 'NVBH', 'BH', 077202069605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV03', 'Heady', 'Ferrick', 'Vincenz', 'iclemenzi2', 'NVBH', 'BH', 077202049605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV04', 'Roxby', 'Szepe', 'Messimili', 'cmartino3', 'NVKHO', 'TK', 077505034605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV05', 'Swindell', 'Cutchee', 'Alphonso', 'rrand4', 'NVKHO', 'TK', 077200034605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV06', 'Tremble', 'Garham', 'Avictor', 'rwiggall5', 'NVKHO', 'TK', 077222034605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV07', 'Dunican', 'Janos', 'Sunshine', 'dcordeix6', 'NVCSKH', 'CSKH', 077112034605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV08', 'Parell', 'Clemas', 'Merrick', 'aszymonowicz7', 'NVCSKH', 'CSKH', 077303034605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV09', 'Stother', 'Manser', 'Hyacinthie', 'tcharley8', 'TPCSKH', 'CSKH', 077202123605); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV10', 'Keepence', 'Carvell', 'Giulietta', 'efigger9', 'QLKHO', 'TK', 077202034127); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV11', 'Gigg', 'Skatcher', 'Freida', 'govittsa', 'TPKHO', 'TK', 077202034125); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV12', 'Evert', 'Medcalfe', 'Gloriane', 'wganforthb', 'QLBH', 'BH', 077202034124); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('NV13', 'Sagerson', 'McVane', 'Rosabella', 'rmaciociac', 'TPBH', 'BH', 077202034789); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('GIAMDOC', 'Rieme', 'Ferrar', 'Jemie', 'twimpd', 'GD', 'BGD', 077202034456); 
insert into NHANVIEN (MaNV, HoNV, HoLotNV, TenNV, username, MaCV, MaPB, CMND) values ('PGIAMDOC', 'Hadleigh', 'Faragher', 'Palm', 'jspentone', 'PGD', 'BGD', 077202034123); 
 
select * from NHANVIEN 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV01', 'dparkeson0@gmail.com', '4 Carberry Circle', 'Male', 0763913058); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV02', 'acarnegy1@gmail.com', '415 Oak Trail', 'Male', 0763987265); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV03', 'iclemenzi2@gmail.com', '8394 Pond Drive', 'Male', 0765751581); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV04', 'cmartino3@gmail.com', '76903 Surrey Circle', 'Male', 0765889141); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV05', 'rrand4@gmail.com', '788 Oneill Hill', 'Female', 0936748631); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV06', 'rwiggall5@gmail.com', '9 Delaware Parkway', 'Female', 0933663517); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV07', 'dcordeix6@gmail.com', '8 Westerfield Plaza', 'Male', 0931158222); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV08', 'aszymonowicz7@gmail.com', '12 Delaware Place', 'Female', 0933306413); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV09', 'tcharley8@gmail.com', '91765 Coolidge Parkway', 'Female', 0933998611); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV10', 'efigger9@gmail.com', '94375 Eastwood Junction', 'Female', 0938745922); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV11', 'govittsa@gmail.com', '456 Mcguire Parkway', 'Male', 0911481113); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV12', 'wganforthb@gmail.com', '759 Lakewood Parkway', 'Female', 0912379143); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('NV13', 'rmaciociac@gmail.com', '7655 Michigan Center', 'Male', 0911292683); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('GIAMDOC', 'twimpd@gmail.com', '5173 Summit Point', 'Male', 0914824907); 
insert into CHITIETNHANVIEN (MaNV, emailNV, DiaChi, GioiTinh, SDT) values ('PGIAMDOC', 'jspentone@gmail.com', '1749 Ridge Oak Way', 'Female', 0917391047); 
 
select * from CHITIETNHANVIEN 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

insert into LOAISANPHAM (MaLoaiSP, TenLoaiSP) values ('LSP01','Giày thể thao nam');
insert into LOAISANPHAM (MaLoaiSP, TenLoaiSP) values ('LSP02','Giày thể thao nữ');
insert into LOAISANPHAM (MaLoaiSP, TenLoaiSP) values ('LSP03','Giày thời trang nam');
insert into LOAISANPHAM (MaLoaiSP, TenLoaiSP) values ('LSP04','Giày thời trang nữ');

 select * from LOAISANPHAM
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into NHACUNGCAP (MaNCC,TenNCC) values ('NCC01','Nike');
insert into NHACUNGCAP (MaNCC,TenNCC) values ('NCC02','Adidas');
insert into NHACUNGCAP (MaNCC,TenNCC) values ('NCC03','Converse');
insert into NHACUNGCAP (MaNCC,TenNCC) values ('NCC04','Bitis');
insert into NHACUNGCAP (MaNCC,TenNCC) values ('NCC05','Balenciaga');

 select * from NHACUNGCAP
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP001',N'Giày thể thao Nam HunterX','LSP01','NCC04');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP002',N'Giày thể thao Nam Converse RunStar','LSP01','NCC03');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP003',N'Giày thể thao Nữ HunterX','LSP02','NCC04');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP004',N'Giày thể thao Nữ Converse RunStar','LSP02','NCC03');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP005',N'Giày thời trang Nam Chuck Black&White','LSP03','NCC05');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP006',N'Giày thời trang Nam LuxurySneaker','LSP03','NCC03');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP007',N'Giày thời trang Nữ Chuck Black&White','LSP04','NCC05');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP008',N'Giày thời trang Nữ LuxurySneaker','LSP04','NCC03');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP009',N'Giày thể thao Nam Adidas','LSP01','NCC02');
insert into SANPHAM (MaSP,TenSP,MaLoaiSP,MaNCC) values ('SP010',N'Giày thể thao Nữ Nike','LSP02','NCC01');
 select * from SANPHAM
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP01','SP001',400000,N'Còn hàng',35)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP02','SP001',500000,N'Còn hàng',36)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP03','SP002',400000,N'Còn hàng',37)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP04','SP002',200000,N'Còn hàng',40)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP05','SP003',500000,N'Hết hàng',41)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP06','SP003',700000,N'Còn hàng',42)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP07','SP004',500000,N'Còn hàng',43)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP08','SP004',600000,N'Còn hàng',38)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP09','SP005',900000,N'Còn hàng',39)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP10','SP005',100000,N'Còn hàng',40)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP11','SP006',400000,N'Còn hàng',35)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP12','SP006',500000,N'Còn hàng',36)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP13','SP007',400000,N'Còn hàng',37)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP14','SP007',200000,N'Hết Hàng',40)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP15','SP008',500000,N'Còn hàng',41)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP16','SP008',700000,N'Còn hàng',42)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP17','SP009',500000,N'Còn hàng',43)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP18','SP009',600000,N'Còn hàng',38)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP19','SP010',900000,N'Còn hàng',39)
insert into CHITIETSANPHAM ( MaCTSP,MaSP, GiaSP, TinhTrangSP, Size) values ('CSP20','SP010',100000,N'Còn hàng',40)
select * from CHITIETSANPHAM
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP001','NCC04',7,35)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP001','NCC04',7,36)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP002','NCC03',8,37)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP002','NCC03',8,40)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP003','NCC04',0,41)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP003','NCC04',9,42)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP004','NCC03',12,43)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP004','NCC03',12,38)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP005','NCC05',4,39)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP005','NCC05',4,40)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP006','NCC03',7,35)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP006','NCC03',6,36)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP007','NCC05',1,37)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP007','NCC05',0,40)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP008','NCC03',8,41)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP008','NCC03',9,42)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP009','NCC02',7,43)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP009','NCC02',7,38)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP010','NCC01',2,39)
insert into MATHANGNCC (MaSP,MaNCC,SoLuong,Size) values ('SP010','NCC01',2,40)

 select * from MATHANGNCC
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP001',2,2023,18,2,0,16);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP001',3,2023,16,2,0,14);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP001',4,2023,14,0,0,14);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP002',2,2023,20,0,5,15);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP002',3,2023,15,1,0,16);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP002',4,2023,16,0,0,16);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP003',2,2023,12,0,6,6);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP003',3,2023,6,0,0,6);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP003',4,2023,6,3,0,9);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP004',2,2023,15,0,7,8);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP004',3,2023,8,12,0,20);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP004',4,2023,20,4,0,24);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP005',2,2023,15,0,7,8);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP005',3,2023,8,6,0,14);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP005',4,2023,14,0,6,8);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP006',2,2023,15,0,7,8);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP006',3,2023,8,6,0,14);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP006',4,2023,14,0,1,13);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP007',2,2023,15,0,7,8);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP007',3,2023,8,6,0,14);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP007',4,2023,14,13,0,1);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP008',2,2023,17,0,0,17);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP008',3,2023,17,0,0,17);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP008',4,2023,17,0,0,17);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP009',2,2023,15,0,7,8);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP009',3,2023,8,6,0,14);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP009',4,2023,14,0,0,14);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP010',2,2023,10,0,5,5);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP010',3,2023,5,1,0,4);
 insert into TONKHO (MaSP,Thang,Nam,TonDK,TonCK,NhapTK,XuatTK) values('SP010',4,2023,4,0,0,4);
 select * from TONKHO
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH001','2023/02/21','2023/02/22',N'Tiền Mặt'    ,N'Đã giao.'   ,500000,'KH01','NV01');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH002','2023/02/23','2023/02/24',N'Chuyển Khoản',N'Đã giao.'   ,800000,'KH03','NV02');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH003','2023/02/27','2023/02/28',N'Tiền Mặt'    ,N'Đã giao.'   ,1000000,'KH04','NV03');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH004','2023/02/28','2023/03/01',N'Tiền Mặt'    ,N'Đã giao.'   ,700000,'KH02','NV02');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH005','2023/02/27','2023/03/01',N'Chuyển Khoản',N'Đã giao.'   ,400000,'KH06','NV01');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH006','2023/03/01','2023/03/03',N'Chuyển Khoản',N'Đã giao.'   ,1200000,'KH07','NV03');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH007','2023/03/05','2023/03/06',N'Tiền Mặt'    ,N'Đã giao.'   ,500000,'KH03','NV02');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH008','2023/03/09','2023/03/09',N'Chuyển Khoản',N'Đã giao.'   ,600000,'KH06','NV01');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH009','2023/03/15','2023/03/16',N'Tiền Mặt'    ,N'Đã giao.'   ,1400000,'KH02','NV02');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH010','2023/03/21','2023/03/22',N'Tiền Mặt'    ,N'Đã giao.'   ,1700000,'KH08','NV03');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH011','2023/03/21','2023/03/22',N'Chuyển Khoản',N'Đã giao.'   ,900000,'KH10','NV02');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH012','2023/03/27','2023/03/28',N'Chuyển Khoản',N'Đã giao.'   ,500000,'KH07','NV02');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH013','2023/04/01','2023/04/2',  N'Tiền Mặt'    ,N'Đang giao..',300000,'KH09','NV01');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH014','2023/04/01','2023/04/2',  N'Chuyển Khoản',N'Đang giao..',400000,'KH05','NV01');
insert into DONHANG(MaDH,NgayDatHang,NgayGiaoHang,PTThanhToan,TrangThaiDH,TongTien,MaKH,MaNV) values ('DH015','2023/04/02','2023/04/3',  N'Chuyển Khoản',N'Đang giao..',200000,'KH01','NV03');
 select * from DONHANG
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH001','SP001',1,36,500000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH002','SP002',2,37,800000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH003','SP001',1,36,500000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH003','SP003',1,41,500000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH004','SP003',1,42,700000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH005','SP005',2,40,200000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH005','SP010',2,40,200000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH006','SP004',2,38,1200000);
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH007','SP010',5,40,500000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH008','SP009',1,38,600000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH009','SP001',1,36,500000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH009','SP006',1,36,500000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH009','SP010',1,39,900000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH010','SP007',3,37,1200000);
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH010','SP004',1,43,500000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH011','SP005',1,39,900000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH012','SP001',1,36,500000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH013','SP002',1,40,200000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH013','SP005',1,40,100000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH014','SP006',1,35,400000 );
insert into CTDONHANG(MaDH,MaSP,SoLuongDat,Size,DonGia) values ('DH015','SP007',1,40,200000 );

 select * from CTDONHANG
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0001','2023/02/21',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0002','2023/02/23',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0003','2023/02/27',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0004','2023/02/28',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0005','2023/03/01',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0006','2023/03/05',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0007','2023/03/09',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0008','2023/03/15',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0009','2023/03/21',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0010','2023/03/27',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0011','2023/04/01',N'Xuất bán hàng')
insert into PHIEUXUAT(MaPX,NgayXuat,LyDo) values ('PX0012','2023/04/02',N'Xuất bán hàng')

 select * from PHIEUXUAT									
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0001','SP001',1,500000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0002','SP002',2,800000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0003','SP001',1,500000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0003','SP003',1,500000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0003','SP005',2,200000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0003','SP010',2,200000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0004','SP003',1,700000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0006','SP004',2,1200000 )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0007','SP009',5,500000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0008','SP001',1,500000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0008','SP006',1,500000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0008','SP010',1,900000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0009','SP007',3,1200000 )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0009','SP004',1,500000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0009','SP005',1,900000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0010','SP001',1,500000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0011','SP002',1,200000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0011','SP005',1,100000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0011','SP006',1,400000  )
insert into CTPHIEUXUAT(MaPX,MaSP,SoLuongXuat,DonGiaXuat) values ('PX0012','SP007',1,200000  )
																			
 select * from CTPHIEUXUAT
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>>>>>> TanHiep_workspace


