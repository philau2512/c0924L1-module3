-- BƯỚC 1 --
create database if not exists ss5_bai_tap;
use ss5_bai_tap;

-- BƯỚC 2 --
create table products(
	id int auto_increment primary key,
    product_code int,
    product_name varchar(100),
    product_price int,
    product_amount int,
    product_description varchar(255),
    product_status int
);

INSERT INTO products (product_code, product_name, product_price, product_amount, product_description, product_status)
VALUES
(1001, 'Laptop Dell XPS 13', 35000000, 10, 'Laptop mỏng nhẹ, cấu hình cao, phù hợp cho dân văn phòng', 1),
(1002, 'MacBook Pro 16"', 55000000, 5, 'Laptop dành cho lập trình viên và designer', 1),
(1003, 'iPhone 15 Pro Max', 35000000, 20, 'Điện thoại cao cấp của Apple, camera đỉnh cao', 1),
(1004, 'Samsung Galaxy S23 Ultra', 29000000, 15, 'Điện thoại flagship của Samsung, hỗ trợ bút S-Pen', 1),
(1005, 'Tai nghe Sony WH-1000XM5', 8500000, 25, 'Tai nghe chống ồn hàng đầu từ Sony', 1),
(1006, 'Bàn phím cơ Keychron K8', 2500000, 30, 'Bàn phím cơ không dây, hỗ trợ Mac và Windows', 1),
(1007, 'Chuột Logitech MX Master 3', 2200000, 40, 'Chuột không dây cho dân văn phòng và designer', 1),
(1008, 'Màn hình LG UltraGear 27"', 8500000, 12, 'Màn hình gaming 165Hz, độ phân giải 2K', 1),
(1009, 'Ổ cứng SSD Samsung 1TB', 3200000, 50, 'Ổ cứng SSD tốc độ cao dành cho máy tính', 1),
(1010, 'Loa JBL Charge 5', 4200000, 18, 'Loa di động chống nước, bass mạnh', 1);

select * from products;

-- BƯỚC 3 --

-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục) --
create unique index i_product_code on products(product_code);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice) --
create index idx_product_name_price on products(product_name, product_price);

-- kiểm tra index đã tạo --
show index from products;

-- BƯỚC 4 -- 
-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.--
create view product_info as
select product_code, product_name, product_price, product_status
from products;

-- Xem, update và xóa view --
select * from product_info;
update product_info set product_price = 30000000 where product_code = 1001;
drop view product_info;

-- BƯỚC 5 --
-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product --
delimiter //
create procedure get_info_all_product()
begin
	select * from products;
end //
delimiter ;

call get_info_all_product();

-- Tạo store procedure thêm một sản phẩm mới --
delimiter //
create procedure add_new_product(
	in p_product_code int,
    in p_product_name varchar(100),
    in p_product_price int,
    in p_product_amount int,
    in p_product_description varchar(255),
    in p_product_status int
)
begin
	insert into products (product_code, product_name, product_price, product_amount, product_description, product_status) values (p_product_code, p_product_name, p_product_price, p_product_amount, p_product_description, p_product_status);
end //
delimiter ;

-- Tạo store procedure sửa thông tin sản phẩm theo id --
delimiter //
create procedure edit_product_by_id(
	in p_id int,
	in p_product_code int,
    in p_product_name varchar(100),
    in p_product_price int,
    in p_product_amount int,
    in p_product_description varchar(255),
    in p_product_status int
)
begin
	update products
    set
		product_code = p_product_code,
        product_name = p_product_name,
        product_price = p_product_price,
        product_amount = p_product_amount,
        product_description = p_product_description,
        product_status = p_product_status
	where id = p_id;
end //
delimiter ;

-- Tạo store procedure xoá sản phẩm theo id --
delimiter //
create procedure delete_product_by_id(
	in p_id int
)
begin
	delete from products where id = p_id;
end //
delimiter ;