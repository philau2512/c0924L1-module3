create database if not exists erd_to_csdl;
use erd_to_csdl;
create table phieu_xuat(
	so_phieu_xuat int primary key,
    ngay_xuat date
);
create table vat_tu(
	ma_vat_tu int primary key,
    ten_vat_tu varchar(100)
);
create table phieu_nhap(
	so_phieu_nhap int primary key,
    ngay_nhap date
);
create table nha_cung_cap(
	ma_ncc int primary key,
    ten_ncc varchar(100),
    dia_chi varchar(255)
);
create table sdt_ncc(
	ma_ncc int,
    sdt varchar(10),
    primary key (ma_ncc, sdt),
    foreign key (ma_ncc) references nha_cung_cap(ma_ncc)
);
create table don_dat_hang(
	so_dh int primary key,
    ngay_dh date
);
-- tạo bảng trung gian --
create table chi_tiet_phieu_xuat(
	so_phieu_xuat int,
	ma_vat_tu int,
	don_gia_xuat decimal(10,2),
    so_luong_xuat int,
    primary key (so_phieu_xuat, ma_vat_tu),
    foreign key (so_phieu_xuat) references phieu_xuat(so_phieu_xuat),
    foreign key (ma_vat_tu) references vat_tu(ma_vat_tu)
);
create table chi_tiet_phieu_nhap(
	so_pn int,
    ma_vt int,
    dg_nhap decimal(10,2),
    sl_nhap int,
    primary key (so_pn, ma_vt),
    foreign key (so_pn) references phieu_nhap(so_phieu_nhap),
    foreign key (ma_vt) references vat_tu(ma_vat_tu)
);
create table chi_tiet_don_dat_hang(
	so_dh int,
    ma_vt int,
    primary key (so_dh, ma_vt),
    foreign key (so_dh) references don_dat_hang(so_dh),
    foreign key (ma_vt) references vat_tu(ma_vat_tu)
);
create table cung_cap(
	ma_ncc int,
    so_dh int,
    primary key (ma_ncc, so_dh),
    foreign key (ma_ncc) references nha_cung_cap(ma_ncc),
    foreign key (so_dh) references don_dat_hang(so_dh)
);