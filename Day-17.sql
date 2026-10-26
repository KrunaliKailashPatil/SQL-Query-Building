CREATE TABLE employee_sales
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(30),
    department VARCHAR(30),
    salary INT,
    sales_target INT,
    actual_sales INT,
    experience INT
);

INSERT INTO employee_sales VALUES
(301, 'Aarav',  'Electronics', 45000, 100000, 120000, 5),
(302, 'Diya',   'Clothing',    32000,  60000,  55000, 2),
(303, 'Ishaan', 'Electronics', 52000, 120000, 135000, 7),
(304, 'Sara',   'Furniture',   38000,  80000,  90000, 4),
(305, 'Kabir',  'Clothing',    35000,  70000,  85000, 3),
(306, 'Anaya',  'Furniture',   42000,  90000,  75000, 6),
(307, 'Vivaan', 'Electronics', 48000, 110000, 105000, 5),
(308, 'Myra',   'Clothing',    30000,  50000,  65000, 1),
(309, 'Reyansh','Furniture',   40000,  85000, 100000, 8),
(310, 'Kiara',  'Electronics', 55000, 130000, 145000, 9);

select * from employee_sales;

-- Question 1 — Find employees earning above the company average salary
select employee_name, salary
from employee_sales
where salary > (select avg(salary)
                from employee_sales);

-- Question 2 — Find employees whose sales exceed the highest Clothing sales
select employee_name, salary ,actual_sales
from employee_sales
where actual_sales > (select max(actual_sales)
                      from employee_sales
                      where department = 'Clothing');

-- Question 3 — Find employees with more experience than every Clothing employee
select employee_name, salary ,department
from employee_sales
where experience > all (select experience
                        from employee_sales
                        where department = 'Clothing');

-- Question 4 — Find the lowest-paid employee in each department
select employee_name, salary ,department
from employee_sales as e1
where salary = (select min(salary)
                from employee_sales as e2
                where e2.department=e1.department);

-- Question 5 — Find employees whose sales exceed their department's average sales
select employee_name, salary ,department
from employee_sales as e1
where actual_sales > (select avg(actual_sales)
                from employee_sales as e2
                where e2.department=e1.department);

-- Question 6 — Find employees whose salary matches a Furniture employee's salary
select employee_name,salary,department
from employee_sales
where salary in (select salary 
                 from employee_sales
                 where department = 'Furniture');

-- Question 7 — Find the employee with the highest sales target in each department
select employee_name,salary,department
from employee_sales as e2
where sales_target = (select max(sales_target)
                      from employee_sales as e1
                      where e2.department=e1.department);

-- Question 8 — Find employees whose sales exceed the sales of the least experienced employee
select employee_name,salary,department
from employee_sales
where actual_sales > (select actual_sales
                      from employee_sales
                      where experience = (select min(experience)
                                          from employee_sales));

-- Question 9 — Find employees earning less than the average salary of experienced employees
select employee_name,salary,department
from employee_sales 
where salary < (select avg(salary)
                from employee_sales
                where experience <= 5);

-- Question 10 — Find employees earning more than every employee with less than 3 years of experience
select employee_name,salary,department
from employee_sales 
where salary > all(select salary
                   from employee_sales
                   where experience < 3);

