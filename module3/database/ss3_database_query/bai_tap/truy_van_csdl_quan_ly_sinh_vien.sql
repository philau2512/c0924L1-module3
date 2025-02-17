use ss2_quan_ly_sinh_vien;

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’--
select * from student where student_name like "h%";

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.--
select * from class where month(start_date)=12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.--
select * from subject where credit in (3,4,5);

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2. --
update student set student_id = 2 where student_name = 'Hung';

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần. -- 
select student.student_name as ten_sinh_vien, `subject`.sub_name as mon_hoc, mark.mark as diem_thi
from mark
join student on mark.student_id = student.student_id
join subject on mark.sub_id = subject.sub_id
order by diem_thi desc, student.student_name asc;