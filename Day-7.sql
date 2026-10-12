CREATE TABLE customers_dc
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers_dc VALUES
(501, 'Anaya', 'Pune'),
(502, 'Rohan', 'Mumbai'),
(503, 'Isha', 'Nashik'),
(504, 'Dev', 'Surat'),
(505, 'Mira', 'Pune'),
(506, 'Kunal', 'Delhi');

CREATE TABLE orders_dc
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO orders_dc VALUES
(2001, 501, '2026-07-01', 'Completed', 12000),
(2002, 502, '2026-07-03', 'Pending', 8500),
(2003, 501, '2026-07-08', 'Completed', 3000),
(2004, 503, '2026-07-10', 'Cancelled', 4500),
(2005, 504, '2026-07-12', 'Completed', 15000),
(2006, 505, '2026-07-15', 'Pending', 6000),
(2007, 502, '2026-07-20', 'Completed', 2500);

CREATE TABLE products_dc
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products_dc VALUES
(601, 'Laptop', 'Electronics', 50000),
(602, 'Mobile', 'Electronics', 20000),
(603, 'T-shirt', 'Fashion', 800),
(604, 'Jeans', 'Fashion', 1800),
(605, 'Printer', 'Electronics', 12000),
(606, 'Backpack', 'Accessories', 1500);

CREATE TABLE order_items_dc
(
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2)
);

INSERT INTO order_items_dc VALUES
(1, 2001, 601, 1, 50000),
(2, 2001, 602, 1, 20000),
(3, 2002, 603, 2, 800),
(4, 2003, 604, 1, 1800),
(5, 2004, 602, 1, 20000),
(6, 2005, 601, 1, 50000),
(7, 2005, 605, 1, 12000),
(8, 2006, 603, 3, 800),
(9, 2007, 604, 2, 1800);

CREATE TABLE employees_dc
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees_dc VALUES
(701, 'Aarav', NULL, 'IT', 80000),
(702, 'Sana', 701, 'IT', 55000),
(703, 'Nikhil', 701, 'IT', 60000),
(704, 'Tara', NULL, 'HR', 65000),
(705, 'Yash', 704, 'HR', 40000),
(706, 'Diya', 704, 'HR', 42000);

select * from customers_dc;
select * from orders_dc;
select * from products_dc;
select * from order_items_dc;
select * from employees_dc;

-- Query 1. Display customer names with their order details
select c.customer_name,c.city,o.order_id,o.order_date,o.amount
from customers_dc as c
inner join orders_dc as o
on c.customer_id= o.customer_id;

-- Query 2. Find customers who have never placed an order
select c.customer_name,c.customer_id,c.city
from customers_dc as c
left join orders_dc as o
on c.customer_id=o.customer_id
where o.order_id is null;

-- Query 3. Display all customers, including those without orders
select c.customer_name,c.customer_id,c.city,o.order_id,o.amount,o.status
from customers_dc as c
left join orders_dc as o
on c.customer_id=o.customer_id;

-- Query 4. Find total completed-order amount for each customer
select c.customer_name,c.customer_id,
isnull(sum(case
when o.status = 'Completed'
then o.amount
else 0
end),0)as complete_amount
from customers_dc as c
left join orders_dc as o
on c.customer_id=o.customer_id
group by 
c.customer_id,c.customer_name;

-- Query 5. Display each order with its customer and product names
select c.customer_name,o.order_id,p.product_name,oi.quantity,oi.unit_price
from customers_dc as c
inner join orders_dc as o
on c.customer_id=o.customer_id
inner join order_items_dc as oi
on o.order_id=oi.order_id
inner join products_dc as p
on oi.product_id=p.product_id;

-- Query 6. Find products that have never been ordered
select p.product_id,p.product_name,p.category,p.price
from products_dc as p
left join order_items_dc as oi
on p.product_id=oi.product_id
where oi.item_id is null;

-- Query 7. Calculate quantity sold and sales value by product category
select p.category,sum(isnull(oi.quantity, 0)) as total_quantity,
sum(isnull(oi.quantity * oi.unit_price, 0)) as sales_value
from products_dc as p
left join order_items_dc AS oi
on p.product_id = oi.product_id
group by p.category;

-- Query 8. Find customers who placed more than one order
select c.customer_id,c.customer_name,count(o.order_id) as total_orders
from customers_dc as c
inner join orders_dc as o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
having count(o.order_id) > 1;

-- Query 9. Display all customers and orders using FULL OUTER JOIN
select c.customer_id, c.city,o.order_id,o.status,o.amount
from customers_dc as c
full outer join orders_dc as o
on c.customer_id=o.customer_id;

-- Query 10. Find employees whose salary is greater than their manager's salary
select e.employee_name AS employee_name,e.salary AS employee_salary,
m.employee_name AS manager_name,m.salary AS manager_salary
from employees_dc as e
inner join employees_dc as m
on e.employee_id=m.employee_id
where e.salary > m.salary;
