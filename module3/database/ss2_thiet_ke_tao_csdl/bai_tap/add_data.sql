-- Nhà cung cấp
INSERT INTO nha_cung_cap (ma_ncc, ten_ncc, dia_chi) 
VALUES 
    (1, 'Công ty TNHH Xây Dựng ABC', '123 Nguyễn Văn A, TP.HCM'),
    (2, 'Công ty Thương Mại XYZ', '456 Lê Lợi, Hà Nội');

-- Số điện thoại nhà cung cấp
INSERT INTO sdt_ncc (ma_ncc, sdt) 
VALUES 
    (1, '0987654321'),
    (1, '0901234567'),
    (2, '0912345678');

-- Vật tư
INSERT INTO vat_tu (ma_vat_tu, ten_vat_tu) 
VALUES 
    (101, 'Xi măng'),
    (102, 'Cát'),
    (103, 'Sắt thép');

-- Đơn đặt hàng
INSERT INTO don_dat_hang (so_dh, ngay_dh) 
VALUES 
    (1001, '2025-02-10'),
    (1002, '2025-02-15');

-- Phiếu nhập
INSERT INTO phieu_nhap (so_phieu_nhap, ngay_nhap) 
VALUES 
    (5001, '2025-02-12'),
    (5002, '2025-02-18');

-- Phiếu xuất
INSERT INTO phieu_xuat (so_phieu_xuat, ngay_xuat) 
VALUES 
    (6001, '2025-02-14'),
    (6002, '2025-02-20');
-- Chi tiết phiếu xuất
INSERT INTO chi_tiet_phieu_xuat (so_phieu_xuat, ma_vat_tu, don_gia_xuat, so_luong_xuat) 
VALUES 
    (6001, 101, 55000, 5),  -- 5 tấn xi măng
    (6001, 103, 160000, 3), -- 3 tấn sắt thép
    (6002, 102, 25000, 10); -- 10 tấn cát

-- Chi tiết phiếu nhập
INSERT INTO chi_tiet_phieu_nhap (so_pn, ma_vt, dg_nhap, sl_nhap) 
VALUES 
    (5001, 101, 50000, 20), -- Nhập 20 tấn xi măng với giá 50k
    (5001, 102, 22000, 15), -- Nhập 15 tấn cát với giá 22k
    (5002, 103, 150000, 10); -- Nhập 10 tấn sắt với giá 150k

-- Chi tiết đơn đặt hàng
INSERT INTO chi_tiet_don_dat_hang (so_dh, ma_vt) 
VALUES 
    (1001, 101), -- Đơn đặt hàng 1001 có xi măng
    (1001, 102), -- Đơn đặt hàng 1001 có cát
    (1002, 103); -- Đơn đặt hàng 1002 có sắt thép

-- Cung cấp vật tư từ nhà cung cấp
INSERT INTO cung_cap (ma_ncc, ma_vt) 
VALUES 
    (1, 101), -- Công ty ABC cung cấp xi măng
    (1, 102), -- Công ty ABC cung cấp cát
    (2, 103); -- Công ty XYZ cung cấp sắt thép
-- Kiểm tra danh sách nhà cung cấp và số điện thoại của họ
SELECT nc.ma_ncc, nc.ten_ncc, snc.sdt
FROM nha_cung_cap nc
LEFT JOIN sdt_ncc snc ON nc.ma_ncc = snc.ma_ncc;

-- Kiểm tra danh sách vật tư
SELECT * FROM vat_tu;

-- Kiểm tra chi tiết phiếu nhập
SELECT pn.so_phieu_nhap, pn.ngay_nhap, vt.ten_vat_tu, ctpn.sl_nhap, ctpn.dg_nhap
FROM phieu_nhap pn
JOIN chi_tiet_phieu_nhap ctpn ON pn.so_phieu_nhap = ctpn.so_pn
JOIN vat_tu vt ON ctpn.ma_vt = vt.ma_vat_tu;

-- Kiểm tra chi tiết phiếu xuất
SELECT px.so_phieu_xuat, px.ngay_xuat, vt.ten_vat_tu, ctp.so_luong_xuat, ctp.don_gia_xuat
FROM phieu_xuat px
JOIN chi_tiet_phieu_xuat ctp ON px.so_phieu_xuat = ctp.so_phieu_xuat
JOIN vat_tu vt ON ctp.ma_vat_tu = vt.ma_vat_tu;

-- Kiểm tra danh sách đơn đặt hàng và vật tư trong đơn
SELECT dh.so_dh, dh.ngay_dh, vt.ten_vat_tu
FROM don_dat_hang dh
JOIN chi_tiet_don_dat_hang ctdh ON dh.so_dh = ctdh.so_dh
JOIN vat_tu vt ON ctdh.ma_vt = vt.ma_vat_tu;

-- Kiểm tra danh sách vật tư được cung cấp bởi các nhà cung cấp
SELECT cc.ma_ncc, nc.ten_ncc, vt.ten_vat_tu
FROM cung_cap cc
JOIN nha_cung_cap nc ON cc.ma_ncc = nc.ma_ncc
JOIN vat_tu vt ON cc.ma_vt = vt.ma_vat_tu;