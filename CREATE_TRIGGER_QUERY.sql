USE [fashionDatabase]
GO

--Trigger đặt giá trị mặc định cho tình trạng sản phẩm = 1
CREATE OR ALTER TRIGGER trg_GiaTri_MacDinh_TinhTrang_SanPham
ON SANPHAM
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SANPHAM
	SET TinhTrangSP = 1
	WHERE MaSP IN (SELECT MaSP FROM inserted);
END;
go
-- trigger nếu số lượng của 1 sản phẩm = 0 thì tình trạng sản phẩm =0
CREATE OR ALTER TRIGGER trg_KichCo_SoLuong_Zero
ON KICHCO_SANPHAM
AFTER UPDATE 
AS
BEGIN
IF (UPDATE(SoLuong))
BEGIN
UPDATE SANPHAM
SET TinhTrangSP = 0
WHERE MaSP IN (SELECT MaSP FROM KICHCO_SANPHAM WHERE MaKC = 'KC00000001' AND SoLuong = 0)
  AND MaSP IN (SELECT MaSP FROM KICHCO_SANPHAM WHERE MaKC = 'KC00000002' AND SoLuong = 0)
  AND MaSP IN (SELECT MaSP FROM KICHCO_SANPHAM WHERE MaKC = 'KC00000003' AND SoLuong = 0)
  AND MaSP IN (SELECT MaSP FROM KICHCO_SANPHAM WHERE MaKC = 'KC00000004' AND SoLuong = 0)
  AND MaSP IN (SELECT MaSP FROM KICHCO_SANPHAM WHERE MaKC = 'KC00000005' AND SoLuong = 0)
  AND MaSP IN (SELECT MaSP FROM KICHCO_SANPHAM WHERE MaKC = 'KC00000006' AND SoLuong = 0)
  AND MaSP IN (SELECT MaSP FROM KICHCO_SANPHAM WHERE MaKC = 'KC00000007' AND SoLuong = 0)
  AND MaSP IN (SELECT MaSP FROM KICHCO_SANPHAM WHERE MaKC = 'KC00000008' AND SoLuong = 0)
  ;
END
END;

GO

-- trigger Sau khi hủy đơn ở CHITIETDONHANG thì sẽ cập nhật lại số lượng của Sản Phẩm và Tổng giá trị của Đơn Hàng
CREATE OR ALTER TRIGGER trg_HuyDon
ON CHITIET_DONHANG
AFTER DELETE
AS
BEGIN
	DECLARE @masp VARCHAR(50), @soluong INT, @size char(10), @dongia numeric(18,0), @madh char(10);
	SELECT @masp = MASP, @soluong = SoLuong, @size = MaKC , @dongia=GiaTien*SoLuong, @madh = MaDH
	FROM deleted;

	UPDATE KICHCO_SANPHAM
    SET Soluong = SoLuong + @soluong
    WHERE MASP = @masp and MaKC = @size;

	UPDATE DONHANG
		SET TongTien = TongTien - @dongia
		WHERE MaDH = @madh
END;

GO

--Trigger thông báo nhập hàng khi hàng <10
CREATE OR ALTER TRIGGER tr_ThongBaoNhapHang
ON KICHCO_SANPHAM
AFTER UPDATE
AS
BEGIN
    IF (UPDATE(SoLuong))
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted
            WHERE MaSP = inserted.MaSP AND MaKC = inserted.MaKC AND SoLuong < 10
        )
        BEGIN
            Print N'Cần nhập hàng';
        END
    END
END;

