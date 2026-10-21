CREATE TABLE sq_shop_sales
(
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    product VARCHAR(50),
    category VARCHAR(30),
    quantity INT,
    unit_price INT,
    discount INT,
    payment_mode VARCHAR(20),
    sale_status VARCHAR(20)
);

INSERT INTO sq_shop_sales VALUES
(1, 'Aarav',  'Pune',   'Laptop',    'Electronics', 1, 60000, 5000, 'UPI',  'Completed'),
(2, 'Priya',  'Mumbai', 'Headphones','Electronics', 2,  2000,  200, 'Card', 'Completed'),
(3, 'Rohan',  'Pune',   'Shoes',     'Fashion',     2,  3000,  500, 'UPI',  'Completed'),
(4, 'Sneha',  'Nashik', 'Watch',     'Fashion',     1,  5000,  300, 'Cash', 'Pending'),
(5, 'Ishita', 'Mumbai', 'Phone',     'Electronics', 1, 30000, 2000, 'Card', 'Completed'),
(6, 'Kabir',  'Pune',   'Bag',       'Fashion',     3,  1500,  200, 'UPI',  'Cancelled'),
(7, 'Meera',  'Nashik', 'Tablet',    'Electronics', 2, 20000, 1000, 'UPI',  'Completed'),
(8, 'Arjun',  'Mumbai', 'Shoes',     'Fashion',     1,  4000,  400, 'Cash', 'Completed'),
(9, 'Diya',   'Pune',   'Monitor',  'Electronics', 2, 12000, 1000, 'Card', 'Pending'),
(10,'Vivaan', 'Nashik', 'Bag',       'Fashion',     2,  2500,  300, 'UPI',  'Completed'),
(11,'Anaya',  'Mumbai', 'Laptop',    'Electronics', 1, 55000, 3000, 'UPI',  'Pending'),
(12,'Reyansh','Pune',   'Watch',     'Fashion',     2,  4500,  500, 'Card', 'Completed'),
(13,'Kiara',  'Nashik', 'Phone',     'Electronics', 2, 28000, 1500, 'UPI',  'Completed'),
(14,'Aditya', 'Mumbai', 'Tablet',    'Electronics', 1, 18000,  800, 'Cash', 'Cancelled'),
(15,'Myra',   'Pune',   'Shoes',     'Fashion',     3,  2500,  300, 'Card', 'Completed');

select * from sq_shop_sales;

-- Question 1 — Scalar subquery in the SELECT statement
select product,unit_price,(select max(unit_price)
                           from sq_shop_sales) as [Max Unit Price]
                           from sq_shop_sales;

-- Question 2 — Subquery with CASE
select product,unit_price,
case
when unit_price > (select avg(cast(unit_price as decimal(10,2)))
from sq_shop_sales)
then 'Premiun'
else 'Regular'
end as price_segment
from sq_shop_sales;

-- Question 3 — Subquery in the FROM clause
select category,total_sales
from (select category,sum(quantity*unit_price-discount) as total_sales
      from sq_shop_sales
      where sale_status = 'Completed'
      group by category)
      as category_totals
where total_sales > 50000;

-- Question 4 — Subquery with TOP and ORDER BY
select * from (select TOP 2*
               from sq_shop_sales
               order by unit_price desc,sale_id asc) as [Top Sales]
order by unit_price asc,sale_id desc;

-- Question 5 — Subquery with COUNT in the SELECT list
select s.customer_name ,(select count(*)
                        from sq_shop_sales as s1
                        where s1.customer_name = s.customer_name)
                        as sale_record
from sq_shop_sales as s;

-- Question 6 — Nested subquery
select distinct product,category
from sq_shop_sales
where category = (select Top 1 category 
                  from sq_shop_sales
                  where sale_status = 'Completed'
                  group by category
                  order by sum(quantity * unit_price - discount) desc 
                  );

-- Question 7 — Subquery with UNION inside a derived table
select city from (select city 
                  from sq_shop_sales
                  where sale_status = 'Pending'
                  UNION
                  select city
                  from sq_shop_sales
                  where sale_status = 'Cancelled')
                  as Cities
                  order by city;

-- Question 8 — Subquery with a calculated sales value
select sale_id,customer_name,product,quantity*unit_price-discount as net_sales
from sq_shop_sales
where sale_status = 'Completed'
and 
quantity*unit_price-discount > ( select avg(cast(quantity*unit_price-discount as decimal(12,2)))
from sq_shop_sales
where sale_status = 'Completed');

-- Question 9 — Subquery with INTERSECT
select city from (select city 
                  from sq_shop_sales
                  where sale_status = 'Completed'
                  INTERSECT
                  select city
                  from sq_shop_sales
                  where sale_status = 'Pending')
                  as common_cities
                  order by city;

-- Question 10 — Multi-level subquery with TOP and GROUP BY
select city,total_sales
from (select Top 1
      city,sum(quantity*unit_price-discount) as total_sales
      from sq_shop_sales
      where sale_status = 'Completed'
      group by city
      order by sum(quantity*unit_price-discount) desc)
      as city_totals;
