use m3_c0924l1_jv103;

-- Câu 1: Hiện thị danh sách các lớp có học viên theo học và số lượng học viên của mỗi lớp --
select c.name as class_name, count(s.id) as so_luong from class c 
join student s on s.class_id = c.id
group by c.id;

-- Câu 2.  Tính điểm lớn nhất của mỗi các lớp --
select c.name as class_name, max(s.point) as max_point
from class c
join student s on s.class_id = c.id
group by c.id;

-- Câu 3  Tình điểm trung bình  của từng lớp --
select c.name as class_name, round(avg(s.point),3) as mavg_point
from class c
join student s on s.class_id = c.id
group by c.id;

-- Câu 4 Lấy ra toàn bộ tên và ngày sinh các instructor và student ở CodeGym --
select name, birthday from student
union all
select name, birthday from instructor;

-- Câu 5: Lấy ra top 3 học viên có điểm cao nhất của trung tâm. --
select * from student order by point desc limit 0, 3;

-- Câu 6: Lấy ra các học viên có điểm số là cao nhất của trung tâm. -- 
select * from student where point = (select max(point) from student);

-- Câu 7: lấy ra tất cả các giảng viên chưa từng tham gia giảng dạy -- 
-- join bảng: khuyến khích dùng
select * from instructor i 
left join instructor_class ic on i.id = ic.instructor_id 
where ic.instructor_id is null;

-- câu truy vấn con: 
select * from instructor i where id not in(select distinct instructor_id from instructor_class);
