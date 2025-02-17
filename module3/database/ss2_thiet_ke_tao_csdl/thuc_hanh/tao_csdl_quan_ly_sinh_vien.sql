CREATE DATABASE ss2_quan_ly_sinh_vien;
USE ss2_quan_ly_sinh_vien;

CREATE TABLE class
(
    class_id   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(60) NOT NULL,
    start_date DATETIME    NOT NULL,
    status     BIT
);

CREATE TABLE student
(
    student_id   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(30) NOT NULL,
    address      VARCHAR(50),
    phone        VARCHAR(20),
    status       BIT,
    class_id     INT         NOT NULL,
    FOREIGN KEY (class_id) REFERENCES class (class_id)
);

CREATE TABLE subject
(
    sub_id   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sub_name VARCHAR(30) NOT NULL,
    credit   TINYINT     NOT NULL DEFAULT 1 CHECK (credit >= 1),
    status   BIT                  DEFAULT 1
);

CREATE TABLE mark
(
    mark_id    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sub_id     INT NOT NULL,
    student_id INT NOT NULL,
    mark       FLOAT   DEFAULT 0 CHECK (mark BETWEEN 0 AND 100),
    exam_times TINYINT DEFAULT 1,
    UNIQUE (sub_id, student_id),
    FOREIGN KEY (sub_id) REFERENCES subject (sub_id),
    FOREIGN KEY (student_id) REFERENCES student (student_id)
);

-- Thêm dữ liệu vào bảng class
INSERT INTO class (class_name, start_date, status) VALUES
('Khoa học máy tính', '2023-09-01 08:00:00', 1),
('Công nghệ thông tin', '2023-09-05 08:30:00', 1),
('Kỹ thuật phần mềm', '2023-09-10 09:00:00', 1),
('Hệ thống thông tin', '2023-09-15 09:30:00', 1),
('Trí tuệ nhân tạo', '2023-09-20 10:00:00', 1);

-- Thêm dữ liệu vào bảng student
INSERT INTO student (student_name, address, phone, status, class_id) VALUES
('Nguyễn Văn A', 'Hà Nội', '0987654321', 1, 1),
('Trần Thị B', 'TP Hồ Chí Minh', '0977123456', 1, 2),
('Lê Văn C', 'Đà Nẵng', '0967987654', 1, 3),
('Hoàng Minh D', 'Cần Thơ', '0945123987', 1, 4),
('Phạm Thị E', 'Hải Phòng', '0932456789', 1, 5),
('Bùi Hữu F', 'Bắc Ninh', '0987412586', 1, 1),
('Đặng Thùy G', 'Quảng Ninh', '0978854123', 1, 2),
('Võ Thành H', 'Nha Trang', '0912456789', 1, 3),
('Nguyễn Thị I', 'Vũng Tàu', '0909123456', 1, 4),
('Trương Công J', 'Huế', '0989567890', 1, 5);

-- Thêm dữ liệu vào bảng subject
INSERT INTO subject (sub_name, credit, status) VALUES
('Lập trình C++', 3, 1),
('Cấu trúc dữ liệu', 4, 1),
('Hệ điều hành', 3, 1),
('Trí tuệ nhân tạo', 4, 1),
('Phân tích và thiết kế hệ thống', 3, 1),
('Lập trình Java', 3, 1),
('Mạng máy tính', 4, 1),
('Cơ sở dữ liệu', 3, 1),
('Xử lý ảnh', 3, 1),
('Học máy', 4, 1);

-- Thêm dữ liệu vào bảng mark
INSERT INTO mark (sub_id, student_id, mark, exam_times) VALUES
(1, 1, 85, 1),
(2, 1, 78, 1),
(3, 1, 90, 2),
(4, 2, 82, 1),
(5, 2, 75, 2),
(6, 3, 88, 1),
(7, 3, 91, 1),
(8, 4, 69, 1),
(9, 4, 95, 1),
(10, 5, 77, 1),
(1, 6, 86, 1),
(2, 6, 80, 1),
(3, 6, 92, 2),
(4, 7, 83, 1),
(5, 7, 76, 2),
(6, 8, 89, 1),
(7, 8, 92, 1),
(8, 9, 71, 1),
(9, 9, 97, 1),
(10, 10, 79, 1);

-- Kiểm tra dữ liệu
SELECT * FROM class;
SELECT * FROM student;
SELECT * FROM subject;
SELECT * FROM mark;

