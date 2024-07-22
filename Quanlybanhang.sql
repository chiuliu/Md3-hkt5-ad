create database QUANLYBANHANG;
use QUANLYBANHANG;

-- Thiết kế cơ sở dữ liệu
-- B1: Tạo CSDL

CREATE TABLE products (
    product_id VARCHAR(4) PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE NOT NULL,
    status BIT(1) NOT NULL
)ustomers

create table customers(
	customer_id VARCHAR(4) primary key not null,
    name VARCHAR(100) not null,
    email VARCHAR(100) unique not null,
    phone VARCHAR(25) unique not null,
    address VARCHAR(255) not null
); 
-- Tạo bảng orders
CREATE TABLE orders (
    order_id VARCHAR(4) PRIMARY KEY NOT NULL,
    customer_id VARCHAR(4) NOT NULL,
    order_date DATE NOT NULL,
    total_amount DOUBLE NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
)ls

CREATE TABLE orders_details (
  order_id VARCHAR(4) not null,
  product_id VARCHAR(4) not null,
  quantity INT(11) not null,
  price DOUBLE not null,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- B2: Thêm dữ liệu

-- Bảng Customers
insert into customers ( customer_id, name, email, phone, address) values
	('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '0984756322', 'Cầu Giấy, Hà Nội'),
	('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '0984875926', 'Ba Vì,Hà Nội'),
	('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '0904725784', 'Mộc Châu, Sơn La'),
	('C004', 'Phạm Ngọc Anh','anhpn@gmail.com', '0984635365', 'Vinh, Nghệ An'),
	('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '0989735624', 'Hai Bà Trưng, Hà Nội');

-- Bảng Products
insert into products (product_id, name, description, price, status) values
       ('P001', 'iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999, 1),
       ('P002', 'Dell Vostro V3510', 'Core i5, RAM8GB', 14999999, 1),
       ('P003', 'Macbook Pro M2', '8CPU 10CPU 8GB 256GB', 28999999, 1),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999, 1),
       ('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000, 1);
       
-- Bảng Orders
insert into orders (order_id, customer_id, total_amount, order_date)values 
       ('H001', 'C001', 52999997, '2023-2-22'),
       ('H002', 'C001', 80999997, '2023-3-11'),
       ('H003', 'C002', 54359998, '2023-1-22'),
       ('H004', 'C003', 102999995, '2023-3-14'),
       ('H005', 'C003', 80999997, '2022-3-12'),
       ('H006', 'C004', 110449994, '2023-2-1'),
       ('H007', 'C004', 79999996, '2023-3-29'),
       ('H008', 'C004', 29999998, '2023-2-14'),
       ('H009', 'C005', 28999999, '2023-1-10'),
       ('H010', 'C005', 149999994, '2023-4-1');
       
-- Bảng Order Detail

insert into orders_details (order_id, product_id, price, quantity) values
       ('H001', 'P002', 14999999, 1),
       ('H001', 'P004', 18999999, 2),
       ('H002', 'P001', 22999999, 1),
       ('H002', 'P003', 28999999, 2),
       ('H003', 'P004', 18999999, 2),
       ('H003', 'P005',  4090000, 4),
       ('H004', 'P002', 14999999, 3),
       ('H004', 'P003', 28999999, 2),
       ('H005', 'P001', 22999999, 1),
       ('H005', 'P003', 28999999, 2),
       ('H006', 'P005',  4090000, 5),
       ('H006', 'P002', 14999999, 6),
       ('H007', 'P004', 18999999, 3),
       ('H007', 'P001', 22999999, 1),
       ('H008', 'P002', 14999999, 2),
       ('H009', 'P003', 28999999, 1),
       ('H010', 'P003', 28999999, 2),
       ('H010', 'P001', 22999999, 4); 
       
       select * from customers;
       select * from products;
       select * from orders;
       select * from orders_details;
       
-- B3: Truy vấn dữ liệu
-- 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers 

select name as 'tên' , email , phone as 'số điện thoại' , address as 'địa chỉ' from customers;

-- 2. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023

-- (thông tin bao gồm tháng và tổng doanh thu)

select c.name, c.phone, c.address from customers c
inner join orders o on c.customer_id = o.customer_id
where month(o.order_date) = 3 and year(o.order_date) = 2023;

-- 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023

-- (thông tin bao gồm tháng và tổng doanh thu )

select month(order_date) as 'tháng',  format(round(sum(total_amount)),1,'vi_VN') as 'Tổng doanh thu'
from orders where year(order_date) = 2023 
group by month(order_date) 
order by month(order_date) asc;

-- 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 
-- (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại).
select c.name as 'Tên khách hàng', c.address as 'Địa chỉ',c.email , c.phone as 'Số điện thoại'
from customers c where c.customer_id  
not in (
    select distinct customer_id from orders o
    where month(o.order_date) = 2 and year(o.order_date) = 2023
);

-- B4: : Tạo View, Procedure
-- 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : 
-- Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn

CREATE VIEW getInformationOrder AS
    SELECT 
        c.name, c.phone, c.address, o.total_amount, o.order_date
    FROM
        orders o
            INNER JOIN
        customers c ON o.customer_id = c.customer_id;

SELECT 
    *
FROM
    getInformationOrder;
 
 -- 2. Tạo VIEW hiển thị thông tin khách hàng gồm : 
 -- tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt.

CREATE VIEW getInformationCustomers AS
    SELECT 
        c.name, c.address, c.phone, COUNT(o.order_id) AS total_order
    FROM
        customers c
            LEFT JOIN
        orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id;

 
 -- 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm,
 -- mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm
 
create view showInformationProduct as select p.name as 'Tên sản phẩm', p.description as 'Mô tả' , format(round(p.price),1,'vi_VN') as 'Giá' , sum(od.quantity) as 'Tổng số lượng đã bán ra' from products p inner join orders_details od on p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id group by p.product_id;

-- 4. Đánh Index cho trường `phone` và `email` của bảng Customer
create index index_of_phone on customers(phone);
create index index_of_email on customers(email);

-- 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng

delimiter //
create procedure getAllCustomers(
	in customer_id_in varchar(4)
)
begin 
	select * from customers where customer_id = customer_id_in;
end; //
delimiter ;

 call getAllCustomers('C001');
 
 -- 6.Tạo PROCEDURE lấy thông tin của tất cả sản phẩm.
 
 delimiter //
create procedure getAllProducts ()
begin
	select * from products;
end; //
	
delimiter ;

 call getAllproducts();
 
 -- 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng
 
 delimiter //
create procedure getListOrdersByCustomer(
	in customer_id_in varchar(4)
)
begin
	select * from orders where customer_id = customer_id_in;
end;//

delimiter ;

call getListOrdersByCustomer('C001');
 
 









       
       
              




