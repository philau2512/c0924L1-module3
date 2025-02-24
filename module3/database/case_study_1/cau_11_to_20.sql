use case_study_1;

-- 11. Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.--
select
	dich_vu_di_kem.ma_dich_vu_di_kem,
	dich_vu_di_kem.ten_dich_vu_di_kem
from dich_vu_di_kem
join hop_dong_chi_tiet on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
join hop_dong on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
join loai_khach on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
where loai_khach.ten_loai_khach = "Diamond" and (khach_hang.dia_chi like "%Vinh%" or khach_hang.dia_chi like "%Quảng Ngãi%");

-- 12. Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem 
-- (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng 
-- cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
select
	hop_dong.ma_hop_dong,
    nhan_vien.ho_ten as ho_ten_nhan_vien,
    khach_hang.ho_ten as ho_ten_khach_hang,
    khach_hang.so_dien_thoai as sdt_khach_hang,
    dich_vu.ten_dich_vu,
	coalesce(sum(hop_dong_chi_tiet.so_luong),0) as so_luong_dich_vu_di_kem,
    hop_dong.tien_dat_coc
from hop_dong
join dich_vu on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
join nhan_vien on hop_dong.ma_nhan_vien = nhan_vien.ma_nhan_vien
join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
left join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong

where ( 
	month(hop_dong.ngay_lam_hop_dong) in (10,11,12) and year(hop_dong.ngay_lam_hop_dong) = 2020
    and not exists (
		select 1
        from hop_dong hd_2021
        where hd_2021.ma_dich_vu = hop_dong.ma_dich_vu
        and year(hd_2021.ngay_lam_hop_dong) = 2021
        and month(hd_2021.ngay_lam_hop_dong) between 1 and 6
    )
)
group by hop_dong.ma_hop_dong;

-- 13. Hiển thị thông tin các dich_vu_di_kem được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. 
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
select 
	dich_vu_di_kem.ten_dich_vu_di_kem,
    sum(hop_dong_chi_tiet.so_luong) as tong_so_lan_su_dung
from dich_vu_di_kem
join hop_dong_chi_tiet on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
group by dich_vu_di_kem.ten_dich_vu_di_kem
having tong_so_lan_su_dung = (
	select max(tong_su_dung)
    from (
		select sum(so_luong) as tong_su_dung
        from hop_dong_chi_tiet 
        group by ma_dich_vu_di_kem
    ) as subquery
);

-- 14. Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
-- Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).