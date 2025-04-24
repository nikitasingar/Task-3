create database task1;
use task1;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    join_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_id, name, email, city, state, join_date) VALUES
(1, 'Amit Sharma', 'amit@example.com', 'Pune', 'Maharashtra', '2022-01-10'),
(2, 'Priya Singh', 'priya@example.com', 'Mumbai', 'Maharashtra', '2022-03-05'),
(3, 'Raj Patel', 'raj@example.com', 'Ahmedabad', 'Gujarat', '2022-05-15'),
(4, 'Neha Gupta', 'neha@example.com', 'Delhi', 'Delhi', '2022-07-21');

INSERT INTO Products (product_id, product_name, category, price) VALUES
(101, 'Wireless Mouse', 'Electronics', 799.00),
(102, 'Keyboard', 'Electronics', 1199.00),
(103, 'USB Cable', 'Accessories', 299.00),
(104, 'Water Bottle', 'Home', 499.00);

INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES
(1001, 1, '2023-01-12', 'Delivered'),
(1002, 2, '2023-01-15', 'Shipped'),
(1003, 1, '2023-02-20', 'Cancelled'),
(1004, 3, '2023-03-05', 'Delivered');

INSERT INTO Order_Details (order_detail_id, order_id, product_id, quantity, price) VALUES
(1, 1001, 101, 1, 799.00),
(2, 1001, 102, 1, 1199.00),
(3, 1002, 103, 2, 299.00),
(4, 1003, 104, 1, 499.00),
(5, 1004, 101, 1, 799.00),
(6, 1004, 103, 3, 299.00);

select * from Customers;
select * from Products;
select * from orders;
select * from Order_Details;

-- Task 3: SQL for Data Analysis using Ecommerce Dataset

-- 1. SELECT, WHERE, ORDER BY, GROUP BY

-- a) Customers from Maharashtra
select * from Customers where state='Maharashtra';

-- b) Total number of orders per customer
select customer_id,count(order_id) as 'total_orders' from orders 
group by customer_id order by total_orders desc;

-- 2. JOINS (INNER, LEFT, RIGHT)
-- a) INNER JOIN: Orders with Customer info
select o.order_id, o.order_date, c.name from
 Orders o inner join Customers c on o.customer_id=c.customer_id;
 
 -- b) LEFT JOIN: Products with their orders
 
 select p.product_name,od.order_id from 
 Products p left join  Order_Details od on p.product_id=od.product_id;
 
 -- 3. Subqueries
-- Customers with more than 1 order
select name from Customers where customer_id in 
(select customer_id from orders group by customer_id having count(order_id)>1 );

-- 4. Aggregate Functions (SUM, AVG)
-- Total sales per product
SELECT product_id, SUM(quantity * price) AS total_sales
FROM Order_Details
GROUP BY product_id;

-- Average order value
SELECT AVG(quantity * price) AS avg_order_value
FROM Order_Details;

-- 5. Create Views
-- View for customer order summary
CREATE VIEW Customer_Order_Summary AS
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 6. Optimize Queries with Indexes
CREATE INDEX idx_customer_id ON Orders(customer_id);
CREATE INDEX idx_product_id ON Order_Details(product_id);

 
 

 
