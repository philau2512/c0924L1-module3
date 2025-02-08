-- tạo csdl --
create database if not exists c0924L1;
use c0924L1;
-- tạo bảng student --
create table students(
	id int primary key,
    `name` varchar(100) not null default ("abc"),
    `point` float check(point>5)
);
-- thêm dữ liệu vào bảng --
insert into students(id,name,point) values(1,"lau",10), (2,"lau2",9);
insert into students(id,point) values(3,6);
-- đọc dữ liệu --
select * from students;
select * from students where id = 3;
select `name`, `point` from students;
-- update dữ liệu --
update students set name = "lau3" where id = 3;
-- xóa dữ liệu -- 
delete from students where id = 3;
-- xóa bảng --
drop table students;
-- tắt safe mode -- 
SET SQL_SAFE_UPDATES = 0;

alter table students add column address varchar(255);

-- xóa csdl --
drop database c0924l1;