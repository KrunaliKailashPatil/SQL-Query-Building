CREATE TABLE online_orders
(
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(30),
    product VARCHAR(30),
    category VARCHAR(30),
    quantity INT,
    amount INT,
    order_status VARCHAR(20)
);

INSERT INTO online_orders VALUES
(201, 'Anjali', 'Laptop',    'Electronics', 1, 55000, 'Delivered'),
(202, 'Rahul',  'Mouse',     'Electronics', 2,  1200, 'Delivered'),
(203, 'Sneha',  'Chair',     'Furniture',   1,  4500, 'Pending'),
(204, 'Vikas',  'Desk',      'Furniture',   1,  8000, 'Delivered'),
(205, 'Pooja',  'Headphones','Electronics', 2,  3000, 'Cancelled'),
(206, 'Amit',   'Table',     'Furniture',   1,  6500, 'Delivered'),
(207, 'Neha',   'Keyboard',  'Electronics', 1,  2500, 'Pending'),
(208, 'Karan',  'Sofa',      'Furniture',   1, 22000, 'Delivered'),
(209, 'Riya',   'Webcam',    'Electronics', 3,  3600, 'Delivered'),
(210, 'Om',     'Bookshelf', 'Furniture',   1,  7000, 'Cancelled');

SELECT *
FROM online_orders;

-- Question 1: Find orders with an amount greater than Anjali's order
select * 
from online_orders
where amount > all(select amount
                   from online_orders
                   where customer_name = 'Anjali');

-- Question 2: Find orders costing less than the average order amount
select *
from online_orders
where amount < (select avg(amount)
                from online_orders);

-- Question 3: Find orders whose amount is greater than at least one Furniture order
select *
from online_orders
where amount > any(select amount
                   from online_orders
                   where category = 'furniture');

-- Question 4: Find orders with an amount lower than every Electronics order
select *
from online_orders
where amount < all (select amount
                    from online_orders
                    where category = 'Electronics'); 

-- Question 5: Find customers who ordered more quantity than Rahul
select * 
from online_orders
where quantity > all (select quantity
                      from online_orders
                      where customer_name = 'Rahul');

-- Question 6: Find orders that have the same status as Sneha's order
select *
from online_orders
where order_status = all(select order_status
                         from online_orders
                         where customer_name = 'Sneha');

-- Question 7: Find orders with an amount equal to any Delivered order amount in Furniture
select *
from online_orders
where amount IN (select amount
                   from online_orders
                   where category = 'Furniture' and order_status = 'Delivered');

-- Question 8: Find orders whose amount is greater than the highest Cancelled order amount
select *
from online_orders
where amount > (select max(amount)
                from online_orders
                where order_status = 'Cancelled');

-- Question 9: Display every order with the total number of Delivered orders
select *,
(select count(*)
from online_orders
where order_status = 'Delivered')
as Total_Delivered
from online_orders;

-- Question 10: Find the most expensive order in each category
select *
from online_orders as o1
where amount = (select max(amount)
                from online_orders as o2
                where o2.category = o1.category);

-- Question 11 : Find products priced above their category's average price
select *
from online_orders as p
where p.amount > (select avg(p2.amount)
                from online_orders as p2
                where p.category = p2.category);
           
