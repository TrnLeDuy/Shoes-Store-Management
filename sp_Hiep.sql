CREATE PROCEDURE sp_ThemHoaDon
(
    @MaHD char(10),
    @NgayLap DATE,
    @TongTien int,
    @MaKH char(10),
    @MaDH char(10),
    @MaNV char(10),
    @MaLoaiHD char(10)
)
AS
BEGIN
    INSERT INTO HOADON (MaHD, NgayLap, TongTien, MaKH, MaDH, MaNV, MaLoaiHD)
    VALUES (@MaHD, @NgayLap, @TongTien, @MaKH, @MaDH, @MaNV, @MaLoaiHD)
END

------------------------------------------------------------------------------------
create PROCEDURE sp_XoaHoaDon
(
    @MaHD char(10)
)
AS
BEGIN
    DELETE FROM HOADON WHERE MaHD = @MaHD
END


------------------------------------------------------------------------------------
CREATE PROCEDURE sp_SuaHoaDon
(
    @MaHD char(10),
    @NgayLap DATE,
    @TongTien int,
    @MaKH char(10),
    @MaDH char(10),
    @MaNV char(10),
    @MaLoaiHD char(10)
)
AS
BEGIN
    UPDATE HOADON SET NgayLap = @NgayLap, TongTien = @TongTien, MaKH = @MaKH, MaDH = @MaDH, MaNV = @MaNV, MaLoaiHD = @MaLoaiHD
    WHERE MaHD = @MaHD
END


------------------------------------------------------------------------------------
CREATE PROCEDURE sp_XemHoaDon
AS
BEGIN
    SELECT *
    FROM HOADON
END



------------------------------------------------------------------------------------
CREATE PROCEDURE sp_ThemPhieuXuat
    @MaPX char(10),
    @NgayXuat date,
    @LyDo varchar(100)
AS
BEGIN
    INSERT INTO PHIEUXUAT (MaPX, NgayXuat, LyDo)
    VALUES (@MaPX, @NgayXuat, @LyDo)
END

------------------------------------------------------------------------------------
CREATE PROCEDURE sp_SuaPhieuXuat
    @MaPX char(10),
    @NgayXuat date,
    @LyDo varchar(100)
AS
BEGIN
    UPDATE PHIEUXUAT
    SET NgayXuat = @NgayXuat, LyDo = @LyDo
    WHERE MaPX = @MaPX
END


------------------------------------------------------------------------------------
CREATE PROCEDURE sp_XoaPhieuXuat
    @MaPX char(10)
AS
BEGIN
    DELETE FROM PHIEUXUAT
    WHERE MaPX = @MaPX
END
