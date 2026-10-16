CREATE TABLE subq_products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price INT
);

INSERT INTO subq_products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 600),
(3, 'Chair', 'Furniture', 4500),
(4, 'Desk', 'Furniture', 7000),
(5, 'Bottle', 'Accessories', 500),
(6, 'Monitor', 'Electronics', 12000),
(7, 'Lamp', 'Furniture', 1500);

CREATE TABLE subq_customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    age INT
);

INSERT INTO subq_customers VALUES
(101, 'Anaya', 'Pune', 24),
(102, 'Vivaan', 'Mumbai', 32),
(103, 'Ira', 'Surat', 28),
(104, 'Arjun', 'Pune', 40),
(105, 'Myra', 'Delhi', 22),
(106, 'Reyansh', 'Mumbai', 35);

CREATE TABLE subq_orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_status VARCHAR(20)
);

INSERT INTO subq_orders VALUES
(201, 101, 1, 2, 'Completed'),
(202, 102, 3, 1, 'Completed'),
(203, 103, 2, 3, 'Pending'),
(204, 101, 6, 1, 'Completed'),
(205, 104, 4, 1, 'Cancelled'),
(206, 105, 5, 4, 'Completed'),
(207, 102, 7, 2, 'Pending'),
(208, 106, 3, 2, 'Completed');

SELECT * FROM subq_products;
SELECT * FROM subq_customers;
SELECT * FROM subq_orders;

-- Question 1. Find products whose price is greater than the average price of all products.
select product_name,price
from subq_products
where price > (select avg(price)
               from subq_products);

-- Question 2. Find products that cost more than Keyboard.
select product_name,price
from subq_products
where price > (select price
               from subq_products
               where product_name = 'Keyboard');

-- Question 3. Find customers who live in the same city as Anaya.
select customer_name,city
from subq_customers 
where city = (select city
              from subq_customers
              where customer_name = 'Anaya');

-- Question 4. Find orders placed by customers who live in Mumbai.
select order_id,customer_id,product_id,order_status
from subq_orders
where customer_id in (select customer_id
                      from subq_customers
                      where city = 'Mumbai');

-- Question 5. Find products that belong to the same category as Monitor.
select product_name,category
from subq_products
where category = (select category
                  from subq_products
                  where product_name = 'Monitor');

-- Question 6. Find orders whose quantity is greater than the average order quantity.
select order_id,quantity,product_id
from subq_orders
where quantity > (select avg(quantity)
                  from subq_orders);

-- Question 7. Find customers who are older than the average customer age.
select customer_name,age
from subq_customers
where age > (select avg(age)
             from subq_customers);

-- Question 8. Find customers who ordered Chair.
select customer_id,customer_name
from subq_customers
where customer_id in (select customer_id
                      from subq_orders
                      where product_id = (select product_id
                                          from subq_products
                                          where product_name = 'Chair'));

--Question 9. Find products that have never been included in a completed order.
select product_id,product_name
from subq_products
where product_id not in (select product_id
                         from subq_orders
                         where order_status = 'Completed');

-- Question 10. Find customers who have at least one completed order.
select customer_id,customer_name
from subq_customers
where customer_id in (select customer_id
                         from subq_orders
                         where order_status = 'Completed');