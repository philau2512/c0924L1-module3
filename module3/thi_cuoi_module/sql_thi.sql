create database if not exists quan_ly_muon_sach;

use quan_ly_muon_sach;

CREATE TABLE book (
    book_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    description TEXT,
    quantity INT NOT NULL CHECK (quantity >= 0)
);

CREATE TABLE student (
    student_id int PRIMARY KEY auto_increment,
    full_name VARCHAR(255) NOT NULL,
    class_name VARCHAR(50) NOT NULL
);

CREATE TABLE borrow_card (
    borrow_id VARCHAR(10) PRIMARY KEY,
    book_id VARCHAR(10),
    student_id int,
    status BOOLEAN DEFAULT TRUE, -- TRUE: đang mượn, FALSE: đã trả
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

INSERT INTO book (book_id, title, author, description, quantity) VALUES
('S-0001', 'Lập Trình Cơ Bản', 'Nguyễn Văn A', 'Sách về lập trình cơ bản cho người mới bắt đầu', 10),
('S-0002', 'Lập Trình Nâng Cao', 'Trần Thị B', 'Hướng dẫn lập trình nâng cao với các kỹ thuật mới', 1),
('S-0003', 'Học Máy', 'Lê Minh C', 'Sách giới thiệu về học máy và các ứng dụng của nó', 2),
('S-0004', 'Kế Toán Tài Chính', 'Phạm Duy D', 'Cung cấp kiến thức về kế toán tài chính cho doanh nghiệp', 6);

INSERT INTO student (full_name, class_name) VALUES
('Nguyễn Văn A', '10A1'),
('Trần Thị B', '10A2'),
('Lê Minh C', '11B1'),
('Phạm Duy D', '12C1');

INSERT INTO borrow_card (borrow_id, book_id, student_id, status, borrow_date, return_date) VALUES
('MS-0001', 'S-0001', 1, TRUE, '2025-04-01', '2025-04-04'),
('MS-0002', 'S-0002', 2, TRUE, '2025-04-02', '2025-04-04'),
('MS-0003', 'S-0003', 3, TRUE, '2025-04-03', '2025-04-04'),
('MS-0004', 'S-0004', 4, FALSE, '2025-03-28', '2025-04-04');
