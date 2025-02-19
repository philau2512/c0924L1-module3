use case_study_1;

-- 6. Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được khách hàng 
-- thực hiện đặt trong quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
select
	dich_vu.ma_dich_vu,
    dich_vu.ten_dich_vu,
    dich_vu.dien_tich,
    dich_vu.chi_phi_thue,
    loai_dich_vu.ten_loai_dich_vu
from dich_vu
JOIN loai_dich_vu ON dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
left join hop_dong on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
	and year(hop_dong.ngay_lam_hop_dong) = 2021
    and month(hop_dong.ngay_lam_hop_dong) in (1,2,3)
where hop_dong.ma_hop_dong is null;

-- 7. Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ 
-- đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
select
	dich_vu.ma_dich_vu,
    dich_vu.ten_dich_vu,
    dich_vu.dien_tich,
    dich_vu.chi_phi_thue,
    loai_dich_vu.ten_loai_dich_vu
from dich_vu
JOIN loai_dich_vu ON dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
where dich_vu.ma_dich_vu in (
	-- Lấy các dịch vụ đã được đặt trong năm 2020
	select distinct hop_dong.ma_dich_vu
    from hop_dong
    where year(hop_dong.ngay_lam_hop_dong = 2020)
)
and dich_vu.ma_dich_vu not in (
	-- Loại bỏ các dịch vụ đã từng được đặt trong năm 2021
	select distinct hop_dong.ma_dich_vu
    from hop_dong
    where year(hop_dong.ngay_lam_hop_dong = 2021)
);