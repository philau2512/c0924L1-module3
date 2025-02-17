use quan_ly_ban_hang;

-- Thêm dữ liệu -- 
insert into customer (cID,CName,cAge) values (1,'Minh QUan',10), (2,'Ngoc Oanh',20), (3,'Hong Ha',50);
insert into `order` (oID,cID,oDate,oTotalPrice) values	(1, 1, '2006-3-21', null),(2, 2, '2006-3-23', null),(3, 1, '2006-3-16', null);
insert into product (pID,pName,pPrice) values (1, 'May Giat', 3),(2, 'Tu Lanh', 5),(3, 'Dieu Hoa', 7),(4, 'Quat', 1),(5, 'Bep dien', 2);
insert into order_detail (oID,pID,odQTY) values	(1, 1, 3),(1, 3, 7),(1, 4, 2),(2, 1, 1),(3, 1, 8),(2, 5, 4),(2, 3, 3);

-- Xem dữ liệu -- 
select * from customer;
select * from `order`;
select * from product;
select * from order_detail;

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order --
select oID, oDate, oTotalPrice from `order`;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách--
select
	customer.cID as customer_id,
    customer.cName as customer_name,
    `order`.oID as order_id,
    `order`.oDate as order_date,
    product.pID AS product_id, 
    product.pName AS product_name, 
    product.pPrice AS product_price, 
    order_detail.odQTY AS quantity_purchased
from customer
join `order` on customer.cID=`order`.cID
join order_detail on `order`.oID=order_detail.oID
join product on order_detail.pID=product.pID
order by customer_id;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào --
select
	customer.cID as customer_id,
    customer.cName as customer_name
from customer
left join `order`on customer.cID=`order`.cID where `order`.oID is null;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn --
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice) --
select
	`order`.oID as order_id,
    `order`.oDate as order_date,
    order_detail.odQTY * product.pPrice as total_price
from `order`
join order_detail on `order`.oID = order_detail.oID
JOIN product ON order_detail.pID = product.pID;