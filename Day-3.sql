CREATE TABLE customer_data
(
    customer_id INT,
    customer_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    category VARCHAR(30),
    order_amount INT,
    discount INT,
    order_date DATE,
    birth_date DATE,
    phone VARCHAR(20),
    status VARCHAR(20)
);

INSERT INTO customer_data
(customer_id, customer_name, email, city, category,
 order_amount, discount, order_date, birth_date, phone, status)
VALUES
(301, 'Amit Sharma', 'amit@gmail.com', 'Pune', 'Electronics',
 50000, 5000, '2026-01-15', '2000-05-12', '9876543210', 'Completed'),

(302, 'Priya Patel', 'PRIYA@GMAIL.COM', 'Mumbai', 'Fashion',
 25000, 2500, '2026-02-20', '1998-08-25', '9876501234', 'Completed'),

(303, 'Rahul Verma', 'rahul@gmail.com', 'Delhi', 'Electronics',
 75000, 7500, '2026-03-10', '1997-12-05', '9876512345', 'Pending'),

(304, 'Sneha Joshi', 'sneha@gmail.com', 'Pune', 'Beauty',
 18000, 2000, '2026-03-18', '2001-03-15', '9876523456', 'Completed'),

(305, 'Rohit Mehta', 'ROHIT@GMAIL.COM', 'Nashik', 'Grocery',
 12000, 1000, '2026-04-05', '1999-11-20', '9876534567', 'Cancelled'),

(306, 'Pooja Shah', 'pooja@gmail.com', 'Mumbai', 'Fashion',
 45000, 5000, '2026-04-22', '1996-06-18', '9876545678', 'Completed'),

(307, 'Karan Singh', 'karan@gmail.com', 'Bangalore', 'Electronics',
 90000, 10000, '2026-05-12', '1995-01-30', '9876556789', 'Completed'),

(308, 'Anjali Rao', 'anjali@gmail.com', 'Pune', 'Beauty',
 22000, 2000, '2026-05-25', '2000-09-10', '9876567890', 'Pending'),

(309, 'Vikas Gupta', 'vikas@gmail.com', 'Delhi', 'Grocery',
 15000, 1500, '2026-06-08', '1998-04-22', '9876578901', 'Completed'),

(310, 'Riya Kapoor', 'RIYA@GMAIL.COM', 'Mumbai', 'Fashion',
 35000, 3500, '2026-06-20', '1999-07-14', '9876589012', 'Completed'),

(311, 'Akash Jain', 'akash@gmail.com', 'Pune', 'Electronics',
 65000, 6500, '2026-07-05', '1997-10-08', '9876590123', 'Pending'),

(312, 'Neha Desai', 'neha@gmail.com', 'Nashik', 'Beauty',
 28000, NULL, '2026-07-18', '2001-02-19', '9876509876', 'Completed'),

(313, 'Varun Malhotra', 'varun@gmail.com', 'Mumbai', 'Grocery',
 10000, 500, '2026-08-02', '1996-09-25', '9876510987', 'Cancelled'),

(314, 'Meena Iyer', 'meena@gmail.com', 'Pune', 'Fashion',
 55000, 5500, '2026-08-15', '1998-12-12', '9876521098', 'Completed'),

(315, 'Sahil Khan', 'sahil@gmail.com', 'Delhi', 'Electronics',
 80000, 8000, '2026-09-01', '1995-05-28', '9876532109', 'Pending');

 Select * from customer_data;

--1. Display customer name and order amount with an alias
select customer_name as Customer, order_amount as  Amount
from customer_data;

--2. Calculate the final amount after discount
select customer_name,order_amount,order_amount-discount as [Final amount]
from customer_data;

--3. Calculate the discount percentage
select customer_name,order_amount,discount,(discount*100.0/order_amount) as [Discount Percentage]
from customer_data;

--4. Find customers whose final amount is greater than ₹40,000
select customer_name,order_amount,discount,order_amount-discount as [Final amount]
from customer_data
where order_amount-discount>40000;

--5. Display customer names in uppercase
select customer_name,upper(customer_name) as [Upper Name]
from customer_data;

--6. Display customer names in lowercase
select customer_name,lower(customer_name) as [Lower Name]
from customer_data;

--7. Combine customer name and city
select concat(customer_name,' - ',city) as [Customer location]
from customer_data;

--8. Extract the first 5 characters of customer name
select customer_name,substring(customer_name,1,5) as [First Five Characters]
from customer_data;

--9. Find the length of each customer's name
select customer_name,len(customer_name) as [Length of customer name]
from customer_data;

--10. Find customers whose email contains gmail
select customer_name,email
from customer_data
where email like '%gmail%';

--11. Categorize customers based on order amount
select customer_name,order_amount,
case
when order_amount>=50000 then 'High Value'
when order_amount>=20000 then 'Mediun Value'
else 'Low Value'
end as [Customer Category]
from customer_data;

--12. Categorize orders based on status
select customer_name,status,
case
when status='Completed' then 'Successful'
when status='Pending' then 'In prpcess'
when status='Cancelled' then 'Unsuccessful'
else 'Unknown'
end as [Order Status]
from customer_data;

--13. Display the year, month and day of each order
SELECT customer_name,order_date,
YEAR(order_date) AS [Year],
MONTH(order_date) AS [Month],
DAY(order_date) AS [Day]
FROM customer_data;

--14. Find all customers who ordered in June
select customer_name,order_date,order_amount
FROM customer_data
where MONTH(order_date) = 6;

--15. Find customers who were born after 2000
select customer_name,birth_date
from customer_data
where YEAR(birth_date) > 2000;

--16. Calculate how many days have passed since each order
select customer_name, order_date,
DATEDIFF(DAY,order_date,GETDATE()) as [Days Since Order]
FROM customer_data;

--17. Replace NULL discount with 0
select customer_name,order_amount,ISNULL(discount,0) as Discount
from customer_data;

--18. Calculate final amount while handling NULL discount
select customer_name,order_amount,ISNULL(discount,0) as Discount,
order_amount - ISNULL(discount,0) as [Final Amount]
from customer_data;

--19. Find customers whose order amount is between ₹20,000 and ₹60,000
select customer_name,order_amount
from customer_data
where order_amount between 20000 and 60000;

--20. Create a complete customer report using multiple Day 2 concepts
SELECT
    customer_id,
    UPPER(customer_name) AS CustomerName,
    CONCAT(city, ' - ', category) AS CustomerSegment,
    order_amount AS OriginalAmount,
    ISNULL(discount, 0) AS Discount,
    order_amount - ISNULL(discount, 0) AS FinalAmount,

    CASE
        WHEN order_amount >= 50000 THEN 'High Value'
        WHEN order_amount >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS CustomerValue

FROM customer_data
ORDER BY FinalAmount DESC;