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


