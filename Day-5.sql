CREATE TABLE customers_d
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE departments_d
(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees_d
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    manager_id INT,
    salary INT
);

CREATE TABLE products_d
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

CREATE TABLE orders_d4
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20)
);

CREATE TABLE orders_d
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20)
);

CREATE TABLE order_items_d
(
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price INT
);

INSERT INTO customers_d VALUES
(101, 'Amit', 'Pune'),
(102, 'Priya', 'Mumbai'),
(103, 'Rahul', 'Delhi'),
(104, 'Sneha', 'Pune'),
(105, 'Karan', 'Nashik'),
(106, 'Neha', 'Mumbai');

INSERT INTO departments_d VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing');

INSERT INTO employees_d VALUES
(201, 'Raj', 1, NULL, 80000),
(202, 'Meena', 1, 201, 55000),
(203, 'Arjun', 2, NULL, 60000),
(204, 'Pooja', 3, NULL, 65000),
(205, 'Vijay', 4, NULL, 50000),
(206, 'Riya', 4, 205, 40000),
(207, 'Kabir', NULL, 201, 35000);

INSERT INTO products_d VALUES
(301, 'Laptop', 'Electronics', 60000),
(302, 'Phone', 'Electronics', 25000),
(303, 'Shoes', 'Fashion', 3000),
(304, 'Watch', 'Fashion', 5000),
(305, 'Headphones', 'Electronics', 2000);

INSERT INTO orders_d VALUES
(1001, 101, '2026-01-10', 'Completed'),
(1002, 102, '2026-01-15', 'Completed'),
(1003, 101, '2026-02-05', 'Pending'),
(1004, 104, '2026-02-20', 'Completed'),
(1005, 103, '2026-03-01', 'Cancelled');

INSERT INTO order_items_d VALUES
(1, 1001, 301, 1, 60000),
(2, 1001, 302, 2, 25000),
(3, 1002, 303, 2, 3000),
(4, 1003, 302, 1, 25000),
(5, 1004, 304, 1, 5000),
(6, 1005, 303, 1, 3000);

SELECT * FROM customers_d;
SELECT * FROM departments_d;
SELECT * FROM employees_d;
SELECT * FROM products_d;
SELECT * FROM orders_d;
SELECT * FROM order_items_d;

-- Question 1. Display orders with customer names
select o.order_id,c.customer_name,o.order_date,o.status
from customers_d as c
inner join orders_d as o
on c.customer_id = o.customer_id;

-- Question 2. Display all customers, including those without orders
select c.customer_id,c.customer_name, o.order_id,o.status
from customers_d as c
left join orders_d as o
on c.customer_id = o.customer_id;

-- Question 3. Find customers who have never placed an order
select c.customer_id ,c.customer_name ,c.city,o.order_id
from customers_d as c
left join orders_d as o
on c.customer_id = o.customer_id
where o.order_id IS NULL;

-- Question 4. Display all products, including products without sales
select p.product_id,p.product_name,oi.order_id,oi.quantity
from products_d as p
left join order_items_d as oi
on p.product_id = oi.product_id;

-- Question 5. Find products that have never been sold
select  p.product_id,p.product_name,p.category,p.price
from products_d as p
left join order_items_d as od
on p.product_id=od.product_id
where od.order_item_id IS NULL;

-- Question 6. Display employees with their department names
select e.employee_name,d.department_name,e.salary
from employees_d as e
inner join departments_d as d
on e.department_id=d.department_id;

-- Question 7. Display all employees, even if they have no department
select e.employee_name,d.department_name,e.salary
from employees_d as e
left join departments_d as d
on e.department_id=d.department_id;

-- Question 8. Display all departments, including departments without employees
select d.department_name, e.employee_name 
from departments_d as d
left join employees_d as e
on d.department_id=e.department_id;

-- Question 9. Display all records from both sides of a customer-order comparison
SELECT c.customer_name,o.order_id,o.status
FROM customers_d AS c
FULL OUTER JOIN orders_d AS o
ON c.customer_id = o.customer_id;

-- Question 10. Practise RIGHT JOIN to display every product
SELECT oi.order_id, p.product_name,oi.quantity
FROM order_items_d AS oi
RIGHT JOIN products_d AS p
    ON oi.product_id = p.product_id;