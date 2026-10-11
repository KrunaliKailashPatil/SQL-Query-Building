CREATE TABLE customers_db
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers_db VALUES
(101, 'Amit', 'Pune'),
(102, 'Priya', 'Mumbai'),
(103, 'Rahul', 'Delhi'),
(104, 'Sneha', 'Pune'),
(105, 'Karan', 'Nashik');

CREATE TABLE orders_db
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    amount INT,
    status VARCHAR(20)
);

INSERT INTO orders_db VALUES
(1001, 101, 'Laptop', 60000, 'Completed'),
(1002, 102, 'Phone', 25000, 'Completed'),
(1003, 101, 'Mouse', 1000, 'Pending'),
(1004, 104, 'Watch', 5000, 'Completed'),
(1005, 103, 'Shoes', 3000, 'Cancelled'),
(1006, 102, 'Keyboard', 2000, 'Pending');

CREATE TABLE payments_db
(
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_mode VARCHAR(20),
    paid_amount INT
);

INSERT INTO payments_db VALUES
(1, 1001, 'UPI', 60000),
(2, 1002, 'Card', 25000),
(3, 1004, 'Cash', 5000),
(4, 1006, 'UPI', 2000);

CREATE TABLE employees_db
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT,
    department VARCHAR(50)
);

INSERT INTO employees_db VALUES
(201, 'Raj', NULL, 'IT'),
(202, 'Meena', 201, 'IT'),
(203, 'Arjun', 201, 'IT'),
(204, 'Pooja', NULL, 'HR'),
(205, 'Vijay', 204, 'HR');

select * from customers_db;
select * from orders_db;
select * from payments_db;
select * from employees_db;

-- Query 1. Display customer names, cities and their products
select c.customer_name,c.city,o.product_name,o.amount
from customers_db as c
inner join orders_db as o
on c.customer_id=o.customer_id;

--Query 2. Display only completed orders with customer names
select c.customer_name,o.order_id,o.product_name,o.amount,o.status
from customers_db as c
inner join orders_db as o
on c.customer_id=o.customer_id
where o.status = 'Completed';

--Query 3. Find the total order amount for every customer
select c.customer_id,c.customer_name,isnull(sum(o.amount),0) as total_order_amount
from customers_db as c
left join orders_db as o
on c.customer_id=o.customer_id
group by c.customer_name , c.customer_id;

--Query 4. Find orders that do not have a payment record
select o.order_id,o.product_name,o.amount,p.paid_amount
from orders_db as o
right join payments_db as p
on o.order_id=p.order_id;

--Query 5. Display customer names and their payment methods
select c.customer_name,o.order_id,o.product_name,p.payment_mode,p.paid_amount
from customers_db as c
inner join orders_db as o
on c.customer_id=o.customer_id
inner join payments_db as p
on o.order_id=p.order_id;

--Query 6. Find customers who have no completed orders
select c.customer_name,c.city,c.customer_id
from customers_db as c
left join orders_db as o
on c.customer_id=o.customer_id and o.status = 'Completed'
where o.order_id is null;

--Query 7. Display each employee with their manager's name
select e.employee_name,m.employee_name,e.department
from employees_db as e
left join employees_db as m
on e.manager_id=m.employee_id;

--Query 8. Display all orders and show whether payment exists
select o.order_id,p.payment_mode,o.amount,o.product_name,
case 
when p.payment_id is null Then 'No payment record'
else 'Payment record found'
end as payment_status
from orders_db as o
left join payments_db as p
on o.order_id=p.order_id;

--Query 9. Count the number of orders for each customer
select c.customer_id,c.customer_name,count(o.order_id) as total_orders
from customers_db as c
left join orders_db as o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name;

--Query 10. Find orders where the recorded paid amount differs from the order amount
select o.order_id,o.product_name,o.amount,p.paid_amount,
case
when p.payment_id is null then 'Payment Missing'
when o.amount <> p.paid_amount then 'Amount Mismatch'
else 'Amount Matches'
end as payment_status
from orders_db as o
left join payments_db as p
on o.order_id = p.order_id;