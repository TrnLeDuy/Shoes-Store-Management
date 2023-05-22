USE [master]
GO
IF EXISTS (SELECT * FROM sysdatabases WHERE NAME ='fashionDatabase')
DROP DATABASE [fashionDatabase]
GO
/****** Object:  Database [fashionDatabase]    Script Date: 5/19/2023 1:21:29 PM ******/
CREATE DATABASE [fashionDatabase]
ALTER DATABASE [fashionDatabase] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [fashionDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [fashionDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [fashionDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [fashionDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [fashionDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [fashionDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [fashionDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [fashionDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [fashionDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [fashionDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [fashionDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [fashionDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [fashionDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [fashionDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [fashionDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [fashionDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [fashionDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [fashionDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [fashionDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [fashionDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [fashionDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [fashionDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [fashionDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [fashionDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [fashionDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [fashionDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [fashionDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [fashionDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [fashionDatabase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [fashionDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [fashionDatabase] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [fashionDatabase] SET QUERY_STORE = OFF
GO
USE [fashionDatabase]
GO
/****** Object:  Table [dbo].[BIENDONGGIA]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BIENDONGGIA](
	[MaSP] [char](10) NOT NULL,
	[Thang] [int] NOT NULL,
	[Nam] [int] NOT NULL,
	[GiaBan] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_BIENDONGGIA] PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC,
	[Thang] ASC,
	[Nam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIET_DONHANG]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIET_DONHANG](
	[MaDH] [char](10) NOT NULL,
	[MaSP] [char](10) NOT NULL,
	[MaKC] [char](10) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaTien] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_CHITIET_DONHANG] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC,
	[MaSP] ASC,
	[MaKC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIET_PHIEUNHAP]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIET_PHIEUNHAP](
	[MaPNH] [char](10) NOT NULL,
	[MaSP] [char](10) NOT NULL,
	[MaKC] [char](10) NOT NULL,
	[SoLuongNhap] [int] NOT NULL,
	[DonGiaNhap] [decimal](18, 0) NOT NULL,
	[TinhTrang] [int] NOT NULL,
 CONSTRAINT [PK_CHITIET_PHIEUNHAP] PRIMARY KEY CLUSTERED 
(
	[MaPNH] ASC,
	[MaSP] ASC,
	[MaKC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHUCVU]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHUCVU](
	[MaCV] [char](10) NOT NULL,
	[TenCV] [nvarchar](50) NULL,
 CONSTRAINT [PK_CHUCVU] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DONHANG]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DONHANG](
	[MaDH] [char](10) NOT NULL,
	[NgayDatHang] [date] NOT NULL,
	[PTThanhToan] [nvarchar](50) NOT NULL,
	[TrangThaiDH] [int] NOT NULL,
	[TongTien] [decimal](18, 0) NOT NULL,
	[MaKH] [char](10) NOT NULL,
	[MaNV] [char](10) NOT NULL,
 CONSTRAINT [PK_DONHANG] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHACHHANG](
	[MaKH] [char](10) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[SDT] [char](11) NOT NULL,
	[DiaChi] [nvarchar](max) NOT NULL,
	[Email] [char](50) NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [char](1) NOT NULL,
 CONSTRAINT [PK_KHACHHANG] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KICHCO]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KICHCO](
	[MaKC] [char](10) NOT NULL,
	[LoaiKichCo] [float] NOT NULL,
	[GioiTinh] [char](1) NULL,
	[ChieuDai] [float] NOT NULL,
	[ChieuRong] [float] NOT NULL,
 CONSTRAINT [PK_KICHCO] PRIMARY KEY CLUSTERED 
(
	[MaKC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KICHCO_SANPHAM]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KICHCO_SANPHAM](
	[MaSP] [char](10) NOT NULL,
	[MaKC] [char](10) NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_KICHCO_SANPHAM] PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC,
	[MaKC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAISANPHAM]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAISANPHAM](
	[MaLoaiSP] [char](10) NOT NULL,
	[TenLoaiSP] [nvarchar](50) NULL,
 CONSTRAINT [PK_LOAISANPHAM] PRIMARY KEY CLUSTERED 
(
	[MaLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHACUNGCAP]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHACUNGCAP](
	[MaNCC] [char](10) NOT NULL,
	[TenNCC] [nvarchar](100) NULL,
 CONSTRAINT [PK_NHACUNGCAP] PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN](
	[MaNV] [char](10) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[SDT] [char](11) NOT NULL,
	[Email] [char](50) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [char](1) NOT NULL,
	[DiaChi] [nvarchar](max) NOT NULL,
	[Avatar] [char](20) NULL,
	[Username] [char](50) NOT NULL,
	[UserPass] [char](30) NOT NULL,
	[TrangThai] [int] NOT NULL,
	[MaCV] [char](10) NOT NULL,
	[MaPB] [char](10) NOT NULL,
 CONSTRAINT [PK_NHANVIEN] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUNHAPHANG]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUNHAPHANG](
	[MaPNH] [char](10) NOT NULL,
	[NgayNhap] [datetime] NOT NULL,
	[MaNV] [char](10) NOT NULL,
	[TongTien] [decimal](18, 0) NOT NULL,
	[MaNCC] [char](10) NOT NULL,
 CONSTRAINT [PK_PHIEUNHAPHANG] PRIMARY KEY CLUSTERED 
(
	[MaPNH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHONGBAN]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHONGBAN](
	[MaPB] [char](10) NOT NULL,
	[TenPB] [nvarchar](50) NULL,
 CONSTRAINT [PK_PHONGBAN] PRIMARY KEY CLUSTERED 
(
	[MaPB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SANPHAM]    Script Date: 5/19/2023 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANPHAM](
	[MaSP] [char](10) NOT NULL,
	[TenSP] [nvarchar](100) NOT NULL,
	[GiaNhap] [decimal](18, 0) NULL,
	[MauSac] [nvarchar](20) NOT NULL,
	[ChatLieu] [nvarchar](50) NOT NULL,
	[MaLoaiSP] [char](10) NOT NULL,
	[DoiTuong] [nvarchar](20) NOT NULL,
	[HinhAnh] [char](20) NULL,
	[TinhTrangSP] [int] NOT NULL,
 CONSTRAINT [PK_SANPHAM] PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BIENDONGGIA]  WITH CHECK ADD  CONSTRAINT [FK_BIENDONGGIA_SANPHAM] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SANPHAM] ([MaSP])
GO
ALTER TABLE [dbo].[BIENDONGGIA] CHECK CONSTRAINT [FK_BIENDONGGIA_SANPHAM]
GO
ALTER TABLE [dbo].[CHITIET_DONHANG]  WITH CHECK ADD  CONSTRAINT [FK_CHITIET_DONHANG_DONHANG] FOREIGN KEY([MaDH])
REFERENCES [dbo].[DONHANG] ([MaDH])
GO
ALTER TABLE [dbo].[CHITIET_DONHANG] CHECK CONSTRAINT [FK_CHITIET_DONHANG_DONHANG]
GO
ALTER TABLE [dbo].[CHITIET_DONHANG]  WITH CHECK ADD  CONSTRAINT [FK_CHITIET_DONHANG_KICHCO_SANPHAM] FOREIGN KEY([MaSP], [MaKC])
REFERENCES [dbo].[KICHCO_SANPHAM] ([MaSP], [MaKC])
GO
ALTER TABLE [dbo].[CHITIET_DONHANG] CHECK CONSTRAINT [FK_CHITIET_DONHANG_KICHCO_SANPHAM]
GO
ALTER TABLE [dbo].[CHITIET_PHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_CHITIET_PHIEUNHAP_KICHCO_SANPHAM] FOREIGN KEY([MaSP], [MaKC])
REFERENCES [dbo].[KICHCO_SANPHAM] ([MaSP], [MaKC])
GO
ALTER TABLE [dbo].[CHITIET_PHIEUNHAP] CHECK CONSTRAINT [FK_CHITIET_PHIEUNHAP_KICHCO_SANPHAM]
GO
ALTER TABLE [dbo].[CHITIET_PHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_CHITIET_PHIEUNHAP_PHIEUNHAPHANG] FOREIGN KEY([MaPNH])
REFERENCES [dbo].[PHIEUNHAPHANG] ([MaPNH])
GO
ALTER TABLE [dbo].[CHITIET_PHIEUNHAP] CHECK CONSTRAINT [FK_CHITIET_PHIEUNHAP_PHIEUNHAPHANG]
GO
ALTER TABLE [dbo].[DONHANG]  WITH CHECK ADD  CONSTRAINT [FK_DONHANG_KHACHHANG] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KHACHHANG] ([MaKH])
GO
ALTER TABLE [dbo].[DONHANG] CHECK CONSTRAINT [FK_DONHANG_KHACHHANG]
GO
ALTER TABLE [dbo].[DONHANG]  WITH CHECK ADD  CONSTRAINT [FK_DONHANG_NHANVIEN] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[DONHANG] CHECK CONSTRAINT [FK_DONHANG_NHANVIEN]
GO
ALTER TABLE [dbo].[KICHCO_SANPHAM]  WITH CHECK ADD  CONSTRAINT [FK_KICHCO_SANPHAM_KICHCO] FOREIGN KEY([MaKC])
REFERENCES [dbo].[KICHCO] ([MaKC])
GO
ALTER TABLE [dbo].[KICHCO_SANPHAM] CHECK CONSTRAINT [FK_KICHCO_SANPHAM_KICHCO]
GO
ALTER TABLE [dbo].[KICHCO_SANPHAM]  WITH CHECK ADD  CONSTRAINT [FK_KICHCO_SANPHAM_SANPHAM] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SANPHAM] ([MaSP])
GO
ALTER TABLE [dbo].[KICHCO_SANPHAM] CHECK CONSTRAINT [FK_KICHCO_SANPHAM_SANPHAM]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NHANVIEN_CHUCVU] FOREIGN KEY([MaCV])
REFERENCES [dbo].[CHUCVU] ([MaCV])
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [FK_NHANVIEN_CHUCVU]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NHANVIEN_PHONGBAN] FOREIGN KEY([MaPB])
REFERENCES [dbo].[PHONGBAN] ([MaPB])
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [FK_NHANVIEN_PHONGBAN]
GO
ALTER TABLE [dbo].[PHIEUNHAPHANG]  WITH CHECK ADD  CONSTRAINT [FK_PHIEUNHAPHANG_NHACUNGCAP] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NHACUNGCAP] ([MaNCC])
GO
ALTER TABLE [dbo].[PHIEUNHAPHANG] CHECK CONSTRAINT [FK_PHIEUNHAPHANG_NHACUNGCAP]
GO
ALTER TABLE [dbo].[PHIEUNHAPHANG]  WITH CHECK ADD  CONSTRAINT [FK_PHIEUNHAPHANG_NHANVIEN] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[PHIEUNHAPHANG] CHECK CONSTRAINT [FK_PHIEUNHAPHANG_NHANVIEN]
GO
ALTER TABLE [dbo].[SANPHAM]  WITH CHECK ADD  CONSTRAINT [FK_SANPHAM_LOAISANPHAM] FOREIGN KEY([MaLoaiSP])
REFERENCES [dbo].[LOAISANPHAM] ([MaLoaiSP])
GO
ALTER TABLE [dbo].[SANPHAM] CHECK CONSTRAINT [FK_SANPHAM_LOAISANPHAM]
GO
ALTER TABLE [dbo].[PHONGBAN] ADD CONSTRAINT [UC_TenPB] UNIQUE ([TenPB])
GO
ALTER TABLE [dbo].[CHUCVU] ADD CONSTRAINT [UC_TenCV] UNIQUE ([TenCV])
GO
ALTER TABLE [dbo].[NHANVIEN] ADD CONSTRAINT [UC_Username] UNIQUE ([Username])
GO 
USE [master]
GO
ALTER DATABASE [fashionDatabase] SET  READ_WRITE 
GO