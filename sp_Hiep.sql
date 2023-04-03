CREATE OR REPLACE PROCEDURE SP_THEM_HOADON(
  P_MAHD IN VARCHAR2,
  P_NGAYLAP IN DATE,
  P_TONGTIEN IN NUMBER,
  P_MAKH IN VARCHAR2,
  P_MANV IN VARCHAR2,
  P_MADH IN VARCHAR2,
  P_MALOAIHD IN VARCHAR2
) AS
BEGIN
  INSERT INTO HOADON(MAHD, NGAYLAP, TONGTIEN, MAKH, MANV, MADH, MALOAIHD)
  VALUES(P_MAHD, P_NGAYLAP, P_TONGTIEN, P_MAKH, P_MANV, P_MADH, P_MALOAIHD);
  COMMIT;
END;

EXEC sp_Them_HOADON 'HD001', '2022-02-20', 1000000, 'KH001', 'NV001', 'DH001', 'LHD001';

------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_xoa_hoadon (
  p_mahd IN HOADON.MAHD%TYPE
)
IS
BEGIN
  DELETE FROM HOADON WHERE MAHD = p_mahd;
  COMMIT;
  dbms_output.put_line('Xoa hoa don thanh cong!');
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Co loi xay ra: ' || SQLERRM);
END;

sp_xoa_hoadon('HD001');

------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_Sua_HoaDon(
    p_MaHD IN HOADON.MaHD%TYPE,
    p_NgayLap IN HOADON.NgayLap%TYPE,
    p_TongTien IN HOADON.TongTien%TYPE,
    p_MaKH IN HOADON.MaKH%TYPE,
    p_MaNV IN HOADON.MaNV%TYPE,
    p_MaDH IN HOADON.MaDH%TYPE,
    p_MaLoaiHD IN HOADON.MaLoaiHD%TYPE
)
IS
BEGIN
    UPDATE HOADON
    SET NgayLap = p_NgayLap,
        TongTien = p_TongTien,
        MaKH = p_MaKH,
        MaNV = p_MaNV,
        MaDH = p_MaDH,
        MaLoaiHD = p_MaLoaiHD
    WHERE MaHD = p_MaHD;
    COMMIT;
END;
------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_Xem_HoaDon
IS
BEGIN
    SELECT * FROM HOADON;
END sp_Xem_HoaDon;

------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_them_phieuxuat (
    p_ma_px IN PHIEUXUAT.MAPX%TYPE,
    p_ngay_xuat IN PHIEUXUAT.NGAYXUAT%TYPE,
    p_lydo IN PHIEUXUAT.LYDO%TYPE
)
IS
BEGIN
    INSERT INTO PHIEUXUAT (MAPX, NGAYXUAT, LYDO)
    VALUES (p_ma_px, p_ngay_xuat, p_lydo);
    
    COMMIT;
END sp_them_phieuxuat;
------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_sua_phieuxuat (
    p_ma_px IN PHIEUXUAT.MAPX%TYPE,
    p_ngay_xuat IN PHIEUXUAT.NGAYXUAT%TYPE,
    p_lydo IN PHIEUXUAT.LYDO%TYPE
)
IS
BEGIN
    UPDATE PHIEUXUAT
    SET NGAYXUAT = p_ngay_xuat, LYDO = p_lydo
    WHERE MAPX = p_ma_px;
    
    COMMIT;
END sp_sua_phieuxuat;
------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_xoa_phieuxuat (
    p_ma_px IN PHIEUXUAT.MAPX%TYPE
)
IS
BEGIN
    DELETE FROM PHIEUXUAT
    WHERE MAPX = p_ma_px;
    
    COMMIT;
END sp_xoa_phieuxuat;