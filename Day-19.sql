-- CTE (Common Table Expression)

CREATE TABLE OnlineOrders
(
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    category VARCHAR(30),
    city VARCHAR(30),
    amount INT,
    status VARCHAR(20)
);

INSERT INTO OnlineOrders VALUES
(101, 'Asha', 'Laptop', 'Electronics', 'Pune', 55000, 'Completed'),
(102, 'Rohan', 'Mouse', 'Accessories', 'Mumbai', 800, 'Completed'),
(103, 'Meera', 'Chair', 'Furniture', 'Pune', 4500, 'Pending'),
(104, 'Dev', 'Keyboard', 'Accessories', 'Delhi', 1500, 'Completed'),
(105, 'Isha', 'Phone', 'Electronics', 'Mumbai', 25000, 'Completed'),
(106, 'Kabir', 'Desk', 'Furniture', 'Pune', 7000, 'Cancelled'),
(107, 'Tara', 'Monitor', 'Electronics', 'Delhi', 12000, 'Completed'),
(108, 'Nikhil', 'Mouse', 'Accessories', 'Pune', 600, 'Pending');

SELECT * FROM OnlineOrders;

-- Question 1: Display all orders
with orders as
(
select * from OnlineOrders
)
select * from orders;

-- Question 2: Find orders greater than ₹10,000
with greater_order as
(
select * from OnlineOrders
where amount > 10000
)
select * from greater_order;

-- Question 3: Find completed orders
with completed_order as
(
select * from OnlineOrders
where status = 'Completed'
)
select * from completed_order;

-- Question 4: Find orders from Pune
with pune_order as
(
select * from OnlineOrders
where city = 'pune'
)
select * from pune_order;

-- Question 5: Sort orders by amount
with sorted as
(
select * from OnlineOrders
)
select * from sorted
order by amount desc;

-- Question 6: Count orders city-wise
with city_order as
(
select city,count(city) as total_orders
from OnlineOrders
group by city
)
select * from city_order;

-- Question 7: Calculate total amount category-wise
with CategorySales as
(
select category, sum(amount) as total_amount
from OnlineOrders
group by category
)
select * from CategorySales;

-- Question 8: Find orders above the average amount
with avg_count as
(
select avg(amount) as Avg_amount
from OnlineOrders
)
select customer_name,amount
from OnlineOrders
where amount > (select Avg_amount from avg_count);

-- Question 9: Find orders between ₹1,000 and ₹10,000
with middle as
(
select * from OnlineOrders
where amount between 1000 and 10000
)
select * from middle;

-- Question 10: Find Total Sales for Each City
with total_sales as
(
select city,sum(amount) as total_amount
from OnlineOrders
group by city
)
select * from total_sales;