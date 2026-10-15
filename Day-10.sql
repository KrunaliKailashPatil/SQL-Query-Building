CREATE TABLE employees
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary INT,
    city VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'Asha', 10, 45000, 'Pune'),
(2, 'Rahul', 10, 55000, 'Pune'),
(3, 'Neha', 20, 60000, 'Mumbai'),
(4, 'Omar', 20, 50000, 'Mumbai'),
(5, 'Priya', 30, 40000, 'Surat'),
(6, 'Karan', 30, 70000, 'Pune');

CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(101, 'Amit', 'Pune'),
(102, 'Sara', 'Mumbai'),
(103, 'Dev', 'Delhi'),
(104, 'Riya', 'Surat'),
(105, 'Tina', 'Pune');

CREATE TABLE sales
(
    sale_id INT PRIMARY KEY,
    employee_id INT,
    sale_amount INT,
    status VARCHAR(20)
);

INSERT INTO sales VALUES
(1001, 1, 12000, 'Completed'),
(1002, 2, 18000, 'Completed'),
(1003, 2, 7000, 'Pending'),
(1004, 3, 25000, 'Completed'),
(1005, 4, 9000, 'Cancelled'),
(1006, 5, 11000, 'Completed'),
(1007, 6, 30000, 'Completed'),
(1008, 3, 8000, 'Pending');

select * from employees;
select * from customers;
select * from sales;

-- Question 1. Find employees earning more than the company's average salary.
select employee_name,salary
from employees
where salary > (select avg(salary)
                from employees);

-- Question 2. Find the employee or employees earning the highest salary.
select employee_name,salary
from employees
where salary = (select max(salary)
                from employees);

-- Question 3. Find employees who work in the same department as Neha.
select employee_name,department_id
from employees
where department_id IN (select department_id
                        from employees
                        where employee_name = 'Neha');

-- Question 4. Find sales greater than the average sale amount.
select sale_id,employee_id,sale_amount
from sales
where sale_amount > (select avg(sale_amount)
                     from sales);

-- Question 5. Find employees earning less than the average salary.
select employee_name,salary
from employees
where salary > (select avg(salary)
                from employees);

-- Question 6. Find employees earning more than their own department's average salary.
select e.employee_name,e.department_id,e.salary
from employees as e
where e.salary > (select avg(e2.salary)
                  from employees as e2
                  where e2.department_id = e.department_id);

-- Question 7. Find the highest-paid employee in each department.
select e.employee_name,e.department_id,e.salary
from employees as e
where e.salary = (select max(e2.salary)
                   from employees as e2
                   where e2.department_id = e.department_id);

-- Question 8. Find employees who have more than one sales record.
select e.employee_name,e.employee_id
from employees as e
where (select count(*)
       from sales as s
       where s.employee_id = e.employee_id) > 1;

-- Question 9. Display employees earning ₹55,000 or more using a CTE.
with HighSalary as
(
select employee_name,salary
from employees
where salary >= 55000
)
select * from HighSalary;

-- Question 10. Calculate total completed sales for each employee.
with CompletedSales as
(
select employee_id,sale_amount
from sales
where status = 'Completed'
)
select e.employee_name,sum(cs.sale_amount) as total_completed_sales
from employees as e
inner join CompletedSales as cs
on e.employee_id = cs.employee_id
group by e.employee_id, e.employee_name;
