CREATE TABLE customer_purchases
(
    purchase_id INT PRIMARY KEY,
    customer_name VARCHAR(30),
    city VARCHAR(30),
    product VARCHAR(30),
    payment_mode VARCHAR(20),
    purchase_amount INT,
    loyalty_points INT,
    returned BIT
);

INSERT INTO customer_purchases VALUES
(401, 'Nisha',  'Pune',   'Shoes',    'UPI',    3500, 350, 0),
(402, 'Arjun',  'Mumbai', 'Watch',    'Card',   5000, 500, 0),
(403, 'Tara',   'Pune',   'Bag',      'Cash',   1800, 180, 1),
(404, 'Yash',   'Surat',  'Shoes',    'Card',   4200, 420, 0),
(405, 'Mira',   'Mumbai', 'Headphones','UPI',   2600, 260, 1),
(406, 'Dev',    'Pune',   'Watch',    'UPI',    6200, 620, 0),
(407, 'Rhea',   'Surat',  'Bag',      'Cash',   2200, 220, 0),
(408, 'Omkar',  'Mumbai', 'Shoes',    'UPI',    4800, 480, 0),
(409, 'Pallavi','Pune',   'Headphones','Card',  3100, 310, 0),
(410, 'Keshav', 'Surat',  'Watch',    'Card',   5700, 570, 1);

select *
from customer_purchases;

-- Question 1 — Find purchases above the average purchase amount
select customer_name,purchase_amount
from customer_purchases
where purchase_amount > (select avg(purchase_amount)
                         from customer_purchases);

-- Question 2 — Find purchases more expensive than the highest returned purchase
select customer_name,purchase_amount,product
from customer_purchases 
where purchase_amount > (select max(purchase_amount)
                         from customer_purchases
                         where returned = 1);

-- Question 3 — Find customers using the same payment mode as Nisha
select *
from customer_purchases
where payment_mode = (select payment_mode
                      from customer_purchases
                      where customer_name = 'Nisha');

-- Question 4 — Find customers with more loyalty points than every Cash customer
select *
from customer_purchases
where loyalty_points > all(select loyalty_points
                        from customer_purchases
                        where payment_mode = 'Cash');

-- Question 5 — Find purchases of products that have been returned at least once
select * 
from customer_purchases as p1
where exists
(select 1
from customer_purchases as p2
where p1.product=p2.product and p2.returned=1);

-- Question 6 — Find purchases above their own city's average
select * 
from customer_purchases as p1
where p1.purchase_amount > (select avg(purchase_amount)
                            from customer_purchases as p2
                            where p2.city=p1.city);

-- Question 7 — Find purchases from cities where at least one purchase exceeded ₹5,000
select *
from customer_purchases as p1
where exists 
(select 1
from customer_purchases as p2
where p2.city=p1.city and p2.purchase_amount > 5000);

-- Question 8 — Find purchases with amounts matching a returned purchase
select *
from customer_purchases
where purchase_amount in (select purchase_amount
                          from customer_purchases
                          where returned = 1);

-- Question 9 — Find customers with loyalty points above the average of UPI customers
select *
from customer_purchases
where loyalty_points > (select avg(loyalty_points)
                        from customer_purchases
                        where payment_mode='UPI');

-- Question 10 — Find the highest purchase in each payment mode
select *
from customer_purchases as p1
where p1.purchase_amount = (select max(p2.purchase_amount)
                            from customer_purchases as p2
                            where p2.payment_mode=p1.payment_mode);