CREATE TABLE employes (
    employee_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    job_role VARCHAR(50),
    salary INT,
    joining_date DATE,
    city VARCHAR(50),
    performance_score INT,
    manager_id INT
);

INSERT INTO employes
(employee_id, employee_name, department, job_role, salary, joining_date, city, performance_score, manager_id)
VALUES
(201, 'Aarav', 'IT', 'Developer', 55000, '2023-01-15', 'Pune', 85, 205),
(202, 'Priya', 'HR', 'HR Executive', 42000, '2022-06-10', 'Mumbai', 78, 206),
(203, 'Rahul', 'IT', 'Data Analyst', 60000, '2024-02-20', 'Pune', 92, 205),
(204, 'Sneha', 'Finance', 'Accountant', 48000, '2023-08-12', 'Nashik', 74, 207),
(205, 'Vikram', 'IT', 'IT Manager', 85000, '2020-04-18', 'Pune', 95, NULL),
(206, 'Neha', 'HR', 'HR Manager', 75000, '2019-11-25', 'Mumbai', 88, NULL),
(207, 'Rohan', 'Finance', 'Finance Manager', 80000, '2020-09-05', 'Nashik', 91, NULL),
(208, 'Kiran', 'Sales', 'Sales Executive', 38000, '2024-05-14', 'Mumbai', 69, 209),
(209, 'Anjali', 'Sales', 'Sales Manager', 70000, '2021-03-22', 'Mumbai', 90, NULL),
(210, 'Manish', 'IT', 'Tester', 45000, '2023-12-01', 'Pune', 81, 205),
(211, 'Pooja', 'Finance', 'Financial Analyst', 58000, '2024-01-10', 'Nashik', 86, 207),
(212, 'Sameer', 'Sales', 'Sales Executive', 40000, '2022-10-30', 'Pune', 72, 209);

select * from employes;

--1. Find employees whose salary is between ₹40,000 and ₹60,000
select employee_name , salary from employes
where salary between 40000 and 60000;

--2. Find employees whose job role contains the word Analyst
select employee_name, job_role from employes
where job_role like'%Analyst%';

--3. Find employees whose name ends with a
select employee_name from employes
where employee_name like '%a';

--4. Find employees whose city starts with P
select employee_name,city from employes
where city like 'P%';

--5. Display salary plus bonus as total compensation
SELECT employee_name, salary,salary + 5000 as total_compensation
from employes;

--6. Calculate bonus percentage of salary
select employee_name, salary,salary + 5000 as total_compensation,(5000 * 100 / salary) AS bonus_percentage
from employes;

--7. Categorize employees based on performance
select employee_name,performance_score,
CASE
when performance_score>=90 then 'Excellent'
when performance_score>=80 then 'Good'
when performance_score>=70 then 'Average'
else 'poor'
end as performance_category
from employes;

--8. Find the highest salary in each department
select department,max(salary) as highest_salary
from employes
group by department;

--9. Find the lowest salary in each department
select department,min(salary) as lowest_salary
from employes
group by department;

--10. Calculate average performance score by department
select avg(performance_score) as [average performance score],department
from employes
group by department;

--11. Find departments having more than 2 employees
select department,count(*) as employee_count
from employes
group by department
having count(*)>2;

--12. Find the employee with the highest performance score
select employee_name,performance_score
from employes
order by performance_score desc;

--13. Find the second-highest salary
select employee_name,salary 
from employes
order by salary desc
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

--14. Find employees who joined after January 1, 2024
select employee_name, joining_date
from employes
where joining_date>'2024-01-01';

--15. Find employees whose salary is higher than the salary of employee 'Rahul'
select employee_name,salary 
from employes
where salary > (
select salary 
from employes
where employee_name = 'Rahul');

--16. Find employees whose salary is greater than the overall average salary
select employee_name,salary 
from employes
where salary > (select AVG(salary)
from employes);

--17. Find employees with performance higher than the average performance
select employee_name, performance_score
from employes
where performance_score > (select avg(performance_score)
from employes);

--18. Find the department with the highest average salary
select department,avg(salary) as [Avg salary]
from employes
group by department
order by [Avg salary] desc;

--19. Find the total number of employees in each city and show the cities from highest to lowest
select city,count(*) as [Employees_count]
from employes
group by city
order by [Employees_count] desc;

--20. Find employees who have a performance score greater than 85.
select employee_name, performance_score
from employes
where performance_score > 85;