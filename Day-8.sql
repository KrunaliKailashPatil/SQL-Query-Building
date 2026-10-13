CREATE TABLE shop_customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO shop_customers VALUES
(1, 'Aarav', 'Pune'),
(2, 'Diya', 'Mumbai'),
(3, 'Kabir', 'Surat'),
(4, 'Meera', 'Delhi'),
(5, 'Ishaan', 'Nashik'),
(6, 'Sara', 'Pune');

CREATE TABLE shop_orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20)
);

INSERT INTO shop_orders VALUES
(101, 1, '2026-08-01', 'Completed'),
(102, 2, '2026-08-02', 'Pending'),
(103, 1, '2026-08-05', 'Completed'),
(104, 3, '2026-08-07', 'Cancelled'),
(105, 4, '2026-08-10', 'Completed'),
(106, 2, '2026-08-12', 'Completed');

CREATE TABLE shop_products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2)
);

INSERT INTO shop_products VALUES
(201, 'Laptop', 'Electronics', 50000),
(202, 'Mobile', 'Electronics', 20000),
(203, 'Shoes', 'Fashion', 3000),
(204, 'Watch', 'Fashion', 5000),
(205, 'Headphones', 'Electronics', 2500),
(206, 'Backpack', 'Accessories', 1500);

CREATE TABLE shop_order_items
(
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2)
);

INSERT INTO shop_order_items VALUES
(1, 101, 201, 1, 50000),
(2, 101, 202, 1, 20000),
(3, 102, 203, 2, 3000),
(4, 103, 204, 1, 5000),
(5, 104, 202, 1, 20000),
(6, 105, 201, 1, 50000),
(7, 106, 203, 1, 3000),
(8, 106, 205, 2, 2500);

select * from shop_customers;
select * from shop_orders;
select * from shop_products;
select * from shop_order_items;

-- Query 1. Display customer names and their order details
select c.customer_name,o.order_id,o.order_date,o.status
from shop_customers as c
inner join shop_orders as o
on c.customer_id=o.customer_id;

-- Query 2. Display all customers, even if they have no orders
select c.customer_name,c.city,o.order_id,o.status
from shop_customers as c
left join shop_orders as o
on c.customer_id=o.customer_id;

-- Query 3. Find customers who never placed an order
select c.customer_name,c.city,c.customer_id
from shop_customers as c
left join shop_orders as o
on c.customer_id=o.customer_id
where o.order_id IS NULL;

-- Query 4. Find products that have never been ordered
select p.product_name,p.product_id,p.price,p.category
from shop_products as p
left join shop_order_items as oi
on p.product_id=oi.product_id
where oi.product_id IS NULL;

-- Query 5. Display customer names with the products they ordered
select c.customer_name,o.order_id,p.product_name,oi.quantity,oi.unit_price
from shop_customers as c
inner join shop_orders as o
on c.customer_id = o.customer_id
inner join shop_order_items as oi 
on o.order_id=oi.order_id
inner join shop_products as p
on oi.product_id= p.product_id;

-- Query 6. Count orders for every customer
select c.customer_id,c.customer_name,count(o.order_id) as total_orders
from shop_customers as c
left join shop_orders as o
on c.customer_id = o.customer_id
group by
c.customer_id,c.customer_name;

-- Query 7. Calculate completed-order item revenue for each customer
select c.customer_name,sum(oi.quantity * oi.unit_price) as completed_revenue
from shop_customers as c
inner join shop_orders as o
on c.customer_id = o.customer_id
inner join shop_order_items as oi
on o.order_id = oi.order_id
where o.status = 'Completed'
group by c.customer_name;

-- Query 8. Calculate sales value for each product category
select p.category,sum(oi.quantity) as total_quantity,sum(oi.quantity * oi.unit_price) as sales_value
from shop_products as p
inner join shop_order_items as oi
on p.product_id = oi.product_id
group by p.category;

-- Query 9. Show all customers and all orders, including unmatched records
select c.customer_name,c.customer_id as customer_table_id,o.order_id,o.customer_id as order_table_customer_id
from shop_customers as c
full outer join shop_orders as o
on c.customer_id = o.customer_id;

-- Query 10. Find customers who have more than one completed order
select c.customer_name,count(o.order_id) as completed_orders
from shop_customers as c
inner join shop_orders as o
on c.customer_id = o.customer_id
where o.status = 'Completed'
group by c.customer_name
having count(o.order_id) > 1;