CREATE TABLE data (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    category VARCHAR(30),
    city VARCHAR(30),
    quantity INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2),
    order_status VARCHAR(20),
    payment_mode VARCHAR(20),
    order_date DATE
);

INSERT INTO data VALUES
(1001,'Amit','Laptop','Electronics','Pune',2,55000,10,'Delivered','UPI','2025-01-05'),
(1002,'Riya','Mobile','Electronics','Mumbai',3,20000,5,'Delivered','Card','2025-01-08'),
(1003,'Karan','Shoes','Fashion','Pune',4,2500,15,'Cancelled','UPI','2025-01-10'),
(1004,'Neha','Watch','Accessories','Surat',2,5000,10,'Delivered','Cash','2025-01-12'),
(1005,'Rohan','Laptop','Electronics','Mumbai',1,60000,5,'Pending','Card','2025-01-15'),
(1006,'Priya','Dress','Fashion','Ahmedabad',5,3000,20,'Delivered','UPI','2025-01-18'),
(1007,'Jay','Mobile','Electronics','Pune',2,18000,10,'Delivered','Cash','2025-02-02'),
(1008,'Sneha','Shoes','Fashion','Surat',3,3500,5,'Pending','UPI','2025-02-05'),
(1009,'Raj','Watch','Accessories','Mumbai',4,4500,10,'Delivered','Card','2025-02-08'),
(1010,'Pooja','Laptop','Electronics','Ahmedabad',2,58000,15,'Delivered','UPI','2025-02-12'),
(1011,'Mehul','Dress','Fashion','Pune',3,4000,10,'Cancelled','Cash','2025-02-15'),
(1012,'Anjali','Mobile','Electronics','Surat',1,22000,5,'Delivered','Card','2025-02-18'),
(1013,'Vikas','Shoes','Fashion','Mumbai',5,2800,20,'Delivered','UPI','2025-03-01'),
(1014,'Komal','Watch','Accessories','Pune',2,6000,10,'Pending','Cash','2025-03-04'),
(1015,'Nikhil','Laptop','Electronics','Surat',1,65000,5,'Delivered','Card','2025-03-08'),
(1016,'Sonal','Dress','Fashion','Mumbai',4,3500,15,'Delivered','UPI','2025-03-12'),
(1017,'Rahul','Mobile','Electronics','Ahmedabad',3,19000,10,'Cancelled','Cash','2025-03-15'),
(1018,'Divya','Shoes','Fashion','Pune',2,3200,5,'Delivered','Card','2025-03-18'),
(1019,'Harsh','Watch','Accessories','Surat',3,5500,20,'Delivered','UPI','2025-03-20'),
(1020,'Mansi','Laptop','Electronics','Mumbai',2,62000,10,'Pending','Card','2025-03-25');

-- Q1. Create a View named high_value_orders displaying order ID, customer name, product name and price for orders where price is greater than ₹20,000.
create view high_value as
select * from data 
where price > 20000;

select * from high_value;

-- Q2. Create a View named delivered_orders containing only delivered orders from Pune and Mumbai.
create view delivered_orders as
select * from data
where order_status = 'Delivered' and city in ('Pune','Mumbai');

select * from delivered_orders;

-- Q3.Create a View named high_discount_orders displaying orders with a discount greater than or equal to 15%.
create view high_discount_orders as
select * from data
where discount >= 15;

select * from high_discount_orders;

-- Q4. Create a View named electronics_delivered_orders displaying Electronics orders that are delivered and have a quantity greater than 1.
create view electronics_delivered_orders as
select * from data
where category = 'Electronics' and order_status = 'delivered' and quantity > 1 ;

select * from electronics_delivered_orders;

-- Q5. Create a View named january_orders containing all orders placed during January 2025.
create view january_orders as 
select * from data
where order_date between '2025-01-01' and '2025-01-31';

select * from january_orders;

-- Q6. Create a View named category_sales displaying category-wise total sales.
create view category_sales as
select category,sum(quantity*price) as category_wise_sales
from data
group by category;

select * from category_sales;

-- Q7. Create a View named city_order_summary displaying each city and its total number of orders.
create view city_order_summary as 
select city, count(order_id) as total_number
from data
group by city;

select * from city_order_summary;

-- Q8. Create a View named average_order_value displaying the average order value for each payment mode.
create view average_order_value as
select avg(quantity*price) as avg_order
from  data
group by payment_mode;

select * from average_order_value;

/* Q9. Create a View named category_performance displaying:
- Category
- Total orders
- Total quantity sold
- Total revenue */

create view category_performance as 
select category,count(order_status) as total_orders,sum(quantity) as total_quantity_sold,sum(quantity*price) as total_revenue
from data
group by category
having sum(quantity*price) > 100000;

select * from category_performance;

-- Q10. Create a View named customer_purchase_summary displaying customer name, total orders and total purchase amount.
create view customer_purchase_summary as
select customer_name, count(order_id) as total_orders, sum(quantity*price) as purchase_amount
from data
group by customer_name
having sum(quantity*price) > 50000;

select * from customer_purchase_summary;