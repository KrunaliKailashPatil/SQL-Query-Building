CREATE TABLE customers
(
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    registration_date DATE
);
INSERT INTO customers
(
    customer_name,
    city,
    state,
    registration_date
)
VALUES
('Aarav Sharma', 'Pune', 'Maharashtra', '2024-01-15'),
('Priya Patel', 'Mumbai', 'Maharashtra', '2024-02-10'),
('Rahul Verma', 'Nashik', 'Maharashtra', '2024-02-25'),
('Sneha Joshi', 'Surat', 'Gujarat', '2024-03-05'),
('Rohan Mehta', 'Ahmedabad', 'Gujarat', '2024-03-18'),
('Neha Deshmukh', 'Pune', 'Maharashtra', '2024-04-12'),
('Karan Shah', 'Vadodara', 'Gujarat', '2024-04-25'),
('Anjali Patil', 'Mumbai', 'Maharashtra', '2024-05-08'),
('Vikas Gupta', 'Delhi', 'Delhi', '2024-05-20'),
('Pooja Nair', 'Bangalore', 'Karnataka', '2024-06-02'),
('Amit Kulkarni', 'Nagpur', 'Maharashtra', '2024-06-15'),
('Kavita Singh', 'Indore', 'Madhya Pradesh', '2024-07-01'),
('Suresh Yadav', 'Jaipur', 'Rajasthan', '2024-07-18'),
('Meera Iyer', 'Chennai', 'Tamil Nadu', '2024-08-05'),
('Akash Patil', 'Thane', 'Maharashtra', '2024-08-20');

CREATE TABLE products
(
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);
INSERT INTO products
(
    product_name,
    category,
    price,
    stock
)
VALUES
('Laptop', 'Electronics', 65000.00, 25),
('Smartphone', 'Electronics', 30000.00, 40),
('Headphones', 'Electronics', 2500.00, 80),
('Keyboard', 'Electronics', 1500.00, 60),
('Mouse', 'Electronics', 800.00, 100),
('Office Chair', 'Furniture', 8500.00, 20),
('Study Table', 'Furniture', 6500.00, 15),
('Backpack', 'Accessories', 1800.00, 50),
('Smart Watch', 'Electronics', 5000.00, 35),
('Water Bottle', 'Accessories', 700.00, 120),
('Running Shoes', 'Footwear', 4500.00, 45),
('T-Shirt', 'Clothing', 1200.00, 75),
('Jeans', 'Clothing', 2500.00, 50),
('Jacket', 'Clothing', 4000.00, 30),
('Coffee Maker', 'Appliances', 5500.00, 18);

CREATE TABLE orders
(
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_date DATE,
    payment_mode VARCHAR(30),
    order_status VARCHAR(30),
    total_amount DECIMAL(10,2),

    CONSTRAINT FK_orders_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);
INSERT INTO orders
(
    customer_id,
    order_date,
    payment_mode,
    order_status,
    total_amount
)
VALUES
(1,  '2024-08-01', 'UPI',        'Delivered', 67500.00),
(2,  '2024-08-03', 'Credit Card', 'Delivered', 30000.00),
(3,  '2024-08-05', 'Cash',       'Pending',    2500.00),
(4,  '2024-08-07', 'UPI',        'Delivered', 10000.00),
(5,  '2024-08-10', 'Debit Card', 'Cancelled',  6500.00),
(6,  '2024-08-12', 'UPI',        'Delivered',  5300.00),
(7,  '2024-08-14', 'Cash',       'Pending',    5000.00),
(8,  '2024-08-16', 'Credit Card', 'Delivered',  6500.00),
(9,  '2024-08-18', 'UPI',        'Delivered',  8500.00),
(10, '2024-08-20', 'Debit Card', 'Processing',  5500.00),
(11, '2024-08-22', 'UPI',        'Delivered',  5700.00),
(12, '2024-08-24', 'Cash',       'Cancelled',  2500.00),
(13, '2024-08-26', 'Credit Card', 'Delivered',  4500.00),
(14, '2024-08-28', 'UPI',        'Processing', 65000.00),
(15, '2024-08-30', 'Debit Card', 'Delivered',  5200.00);

CREATE TABLE order_items
(
    order_item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),

    CONSTRAINT FK_order_items_orders
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    CONSTRAINT FK_order_items_products
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);
INSERT INTO order_items
(
    order_id,
    product_id,
    quantity,
    unit_price
)
VALUES
(1,  1,  1, 65000.00),
(2,  2,  1, 30000.00),
(3,  3,  1, 2500.00),
(4,  6,  1, 8500.00),
(5,  7,  1, 6500.00),
(6,  9,  1, 5000.00),
(7,  9,  1, 5000.00),
(8,  7,  1, 6500.00),
(9,  6,  1, 8500.00),
(10, 15, 1, 5500.00),
(11, 11, 1, 4500.00),
(12, 13, 1, 2500.00),
(13, 11, 1, 4500.00),
(14, 1,  1, 65000.00),
(15, 12, 2, 1200.00);

CREATE TABLE employees
(
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INT,

    CONSTRAINT FK_employees_manager
    FOREIGN KEY (manager_id)
    REFERENCES employees(employee_id)
);
INSERT INTO employees
(
    employee_name,
    department,
    salary,
    manager_id
)
VALUES
('Rajesh Kumar', 'Management', 120000.00, NULL),
('Sunita Sharma', 'HR', 85000.00, NULL),
('Vijay Mehta', 'Sales', 90000.00, NULL),
('Anil Patel', 'IT', 110000.00, NULL),
('Priya Shah', 'Finance', 95000.00, NULL)

INSERT INTO employees
(
    employee_name,
    department,
    salary,
    manager_id
)
VALUES
('Rohan Joshi', 'IT', 65000.00, 4),
('Neha Patil', 'IT', 60000.00, 4),
('Amit Verma', 'Sales', 55000.00, 3),
('Pooja Deshmukh', 'Sales', 52000.00, 3),
('Karan Shah', 'HR', 50000.00, 2),
('Sneha Patil', 'HR', 48000.00, 2),
('Rahul Gupta', 'Finance', 60000.00, 5),
('Meera Joshi', 'Finance', 58000.00, 5),
('Akash Sharma', 'IT', 58000.00, 4),
('Kavita Rao', 'Sales', 47000.00, 3);

select * from customers;
select * from employees;
select * from products;
select * from orders;
select * from order_items;

--1) Find all completed orders
select * from orders
where order_status = 'Completed';

--2) Find total revenue
select sum(total_amount) as total_revenue
from orders
where order_status = 'Completed';

--3) Find average order value
SELECT avg(total_amount) AS average_order_value
FROM orders
WHERE order_status = 'Completed';

--4) Find orders above ?6,000
select * from orders
where total_amount>6000;

--5) Count orders by payment mode
select payment_mode,count(*) as total_orders
from orders
group by payment_mode;

--6) Find revenue by payment mode
select payment_mode,sum(total_amount) as total_revenue
from orders
group by payment_mode;

--7)Find revenue by city
select c.city,sum(total_amount) as total_revenue
from customers c
inner join orders o
on c.customer_id=o.customer_id
group by c.city;

--8)Find customers who placed more than 5 orders
select customer_id,count(*) as total_orders
from orders
group by customer_id
having count(*) >= 2;

--9) Find the highest order amount
select max(total_amount) as highest_order
from orders;

--10) Find monthly revenue
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(total_amount) AS monthly_revenue
FROM orders
WHERE order_status = 'Completed'
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;