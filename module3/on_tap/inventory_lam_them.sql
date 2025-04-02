CREATE DATABASE IF NOT EXISTS inventory;

USE inventory;

-- Tạo bảng category trước vì bảng products tham chiếu đến bảng này
CREATE TABLE category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50)
);

-- Tạo bảng products sau khi bảng category đã tồn tại
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_code VARCHAR(255) UNIQUE,
    product_name VARCHAR(255),
    unit VARCHAR(50),
    price_per_unit DECIMAL(10, 2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(id)
);

-- Thêm dữ liệu vào bảng category
INSERT INTO category (category_name) VALUES
('Rau'),
('Củ'),
('Hoa'),
('Quả');

-- Thêm dữ liệu mẫu vào bảng products
INSERT INTO products (product_code, product_name, unit, price_per_unit, category_id) VALUES
('NHH-001', 'Cà rốt', 'Kg', 20.50, 2),  -- Củ
('NHH-002', 'Khoai tây', 'Kg', 15.75, 2),  -- Củ
('NHH-003', 'Hoa hồng', 'Cành', 25.00, 3),  -- Hoa
('NHH-004', 'Táo', 'Kg', 30.00, 4),  -- Quả
('NHH-005', 'Rau muống', 'Kg', 10.00, 1),  -- Rau
('NHH-006', 'Cải bắp', 'Kg', 18.00, 1),  -- Rau
('NHH-007', 'Cải thảo', 'Kg', 22.00, 1),  -- Rau
('NHH-008', 'Chanh', 'Kg', 12.00, 4);  -- Quả