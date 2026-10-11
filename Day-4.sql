CREATE TABLE sales_data
(
    sale_id INT,
    customer_name VARCHAR(50),
    department VARCHAR(30),
    category VARCHAR(30),
    product_name VARCHAR(50),
    quantity INT,
    unit_price INT,
    sales_amount INT,
    profit INT,
    sale_date DATE,
    payment_mode VARCHAR(20),
    status VARCHAR(20)
);

INSERT INTO sales_data
(sale_id, customer_name, department, category, product_name,
 quantity, unit_price, sales_amount, profit, sale_date,
 payment_mode, status)
VALUES
(401, 'Amit', 'Electronics', 'Mobile', 'Samsung A15',
 2, 18000, 36000, 5000, '2026-01-05', 'UPI', 'Completed'),

(402, 'Priya', 'Fashion', 'Dress', 'Women Dress',
 3, 2500, 7500, 1800, '2026-01-12', 'Card', 'Completed'),

(403, 'Rahul', 'Electronics', 'Laptop', 'HP Laptop',
 1, 65000, 65000, 8000, '2026-01-18', 'Card', 'Completed'),

(404, 'Sneha', 'Beauty', 'Skincare', 'Face Cream',
 5, 800, 4000, 1200, '2026-02-03', 'UPI', 'Completed'),

(405, 'Rohit', 'Grocery', 'Food', 'Dry Fruits',
 4, 1200, 4800, 1000, '2026-02-10', 'Cash', 'Completed'),

(406, 'Pooja', 'Fashion', 'Shoes', 'Running Shoes',
 2, 3500, 7000, 1600, '2026-02-15', 'UPI', 'Completed'),

(407, 'Karan', 'Electronics', 'Mobile', 'iPhone 15',
 1, 70000, 70000, 9000, '2026-02-22', 'Card', 'Completed'),

(408, 'Anjali', 'Beauty', 'Makeup', 'Foundation',
 4, 1200, 4800, 1500, '2026-03-05', 'UPI', 'Pending'),

(409, 'Vikas', 'Grocery', 'Food', 'Cooking Oil',
 6, 600, 3600, 700, '2026-03-11', 'Cash', 'Completed'),

(410, 'Riya', 'Fashion', 'Dress', 'Party Dress',
 2, 4500, 9000, 2200, '2026-03-18', 'Card', 'Completed'),

(411, 'Akash', 'Electronics', 'Laptop', 'Dell Laptop',
 1, 58000, 58000, 7500, '2026-03-25', 'UPI', 'Completed'),

(412, 'Neha', 'Beauty', 'Skincare', 'Serum',
 3, 1500, 4500, 1300, '2026-04-04', 'UPI', 'Completed'),

(413, 'Varun', 'Grocery', 'Food', 'Rice',
 10, 700, 7000, 1200, '2026-04-12', 'Cash', 'Completed'),

(414, 'Meena', 'Fashion', 'Shoes', 'Sports Shoes',
 2, 4000, 8000, 1900, '2026-04-20', 'Card', 'Completed'),

(415, 'Sahil', 'Electronics', 'Mobile', 'OnePlus',
 2, 30000, 60000, 7000, '2026-05-02', 'UPI', 'Pending'),

(416, 'Amit', 'Electronics', 'Laptop', 'Lenovo Laptop',
 1, 55000, 55000, 7000, '2026-05-10', 'Card', 'Completed'),

(417, 'Priya', 'Fashion', 'Dress', 'Casual Dress',
 4, 2000, 8000, 1800, '2026-05-18', 'UPI', 'Completed'),

(418, 'Rahul', 'Grocery', 'Food', 'Coffee',
 5, 500, 2500, 600, '2026-06-05', 'Cash', 'Completed'),

(419, 'Pooja', 'Beauty', 'Makeup', 'Lipstick',
 6, 700, 4200, 1200, '2026-06-12', 'UPI', 'Completed'),

(420, 'Karan', 'Electronics', 'Mobile', 'Vivo V30',
 2, 28000, 56000, 6500, '2026-06-20', 'Card', 'Completed');

 select * from sales_data;

 -- 1. Find the total number of sales records
 select count(*) as Total_sales
 from sales_data;

-- 2. Find the total revenue
 select sum(sales_amount) as Total_Amount
 from sales_data;

-- 3. Find the average sales amount
 select avg(sales_amount) as Avg_Amount
 from sales_data;

-- 4. Find the highest sale
 select max(sales_amount) as [Highest sales]
 from sales_data;

-- 5. Find the lowest sale
 select min(sales_amount) as [Lowest sales]
 from sales_data;

-- 6. Find total quantity of products sold
select sum(quantity) as [Total quality]
from sales_data;

--7. Find total revenue department-wise
select department , sum(sales_amount) [Total revenue]
from sales_data
group by department;

--8. Find average sales department-wise
select department , avg(sales_amount) [Avg revenue]
from sales_data
group by department;

--9. Find the highest sale in each department
select department , max(sales_amount) [highest sale]
from sales_data
group by department;

--10. Find the lowest sale in each department
select department , min(sales_amount) [Lowest sale]
from sales_data
group by department;

--11. Find the number of sales in each category
select category,count(*) as [Sales]
from sales_data
group by category;

--12. Find category-wise total revenue
select category,sum(sales_amount) as [Total_revenue]
from sales_data
group by category
order by Total_revenue desc;

--13. Find total profit by department
select sum(profit) as profit_group, department
from sales_data
group by department
order by profit_group desc;

-- 14. Find the number of customers
select count(distinct customer_name) as no_customer
from sales_data;

--15. Find customer-wise total spending
select customer_name,sum(sales_amount) as total_spending
from sales_data
group by customer_name
order by total_spending desc;

--16. Find departments whose total revenue is greater than ₹100,000
select department,sum(sales_amount) as revenue
from sales_data
group by department
having sum(sales_amount) > 100000;

--17. Find categories having more than 3 sales
select category, count(*) as numberofsales
from sales_data
group by category
having count(*) > 3;

--18. Find monthly revenue
select month(sale_date) as SaleMonth,
       year(sale_date) as SaleYear,
       sum(sales_amount) as revenue
from sales_data
group by month(sale_date),year(sale_date)
order by SaleMonth,SaleYear;

--19. Find the average profit for each category
select category , avg(profit) as AvgProfit
from sales_data
group by category
order by AvgProfit;

--20. Find departments having average sales greater than ₹30,000
select department,avg(sales_amount) as AvgSales
from sales_data
group by department
having avg(sales_amount) > 30000;