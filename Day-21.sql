CREATE DATABASE company_practice;
USE company_practice;

CREATE TABLE EMP (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    city VARCHAR(30),
    salary INT,
    age INT,
    experience INT,
    joining_year INT
);

INSERT INTO EMP VALUES
(101, 'Amit', 'IT', 'Pune', 45000, 24, 2, 2024),
(102, 'Riya', 'HR', 'Mumbai', 35000, 26, 3, 2023),
(103, 'Karan', 'IT', 'Pune', 65000, 29, 5, 2021),
(104, 'Neha', 'Finance', 'Surat', 55000, 28, 4, 2022),
(105, 'Rohan', 'Sales', 'Mumbai', 30000, 23, 1, 2025),
(106, 'Priya', 'IT', 'Ahmedabad', 75000, 30, 7, 2019),
(107, 'Jay', 'HR', 'Pune', 40000, 27, 4, 2022),
(108, 'Sneha', 'Finance', 'Surat', 60000, 31, 6, 2020),
(109, 'Raj', 'Sales', 'Pune', 38000, 25, 2, 2024),
(110, 'Pooja', 'IT', 'Mumbai', 80000, 32, 8, 2018),
(111, 'Mehul', 'Sales', 'Ahmedabad', 42000, 26, 3, 2023),
(112, 'Anjali', 'HR', 'Surat', 48000, 29, 5, 2021);

SELECT * FROM EMP;

-- Q1. Create a View named employee_details that displays employee ID, employee name and department.
create view employee_details as
select emp_id,emp_name,department
from EMP;

select * from employee_details;

-- Q2. Create a View named it_employee_view that displays only IT department employees.
create view it_employee_view as
select * from EMP
where department='IT';

select * from it_employee_view;

-- Q3. Create a View named high_salary_view to display employees earning more than 50,000.
create view high_salary_view as
select * from EMP
where salary > 50000;

select * from high_salary_view;

-- Q4. Create a View named pune_employee_view to display employees who belong to Pune.
create view pune_employee_view as
select * from EMP
where city='Pune';

select * from pune_employee_view;

-- Q5. Display only employee names and salaries from high_salary_view.
select emp_name,salary
from high_salary_view;

-- Q6. Create a View named experienced_employee_view that displays employees having more than 3 years of experience.
create view experienced_employee_view as
select * from EMP
where experience > 3;

select * from experienced_employee_view;

-- Q7. Create a View named employee_salary_view that displays employee name, department and salary in descending order of salary.
create view employee_salary_view as
select emp_name,department,salary from EMP;

select emp_name,department,salary from employee_salary_view
order by salary desc;

-- Q8. Create a View named department_count_view that displays the total number of employees in each department.
create view department_count_view as
select department,count(*) as total_emp
from EMP
group by department;

select * from department_count_view;

-- Q9. Create a View named department_avg_salary that displays the average salary of each department.
create view department_avg_salary as
select department,avg(salary) as avg_salary
from EMP
group by department;

select * from department_avg_salary;

-- Q10. Create a View named young_employee_view that displays employees whose age is below 28 and salary is above 35,000.
create view young_employee_view as
select * from EMP
where age < 28 and salary > 35000;

select * from young_employee_view;

-- Q11. Create a View named top_salary_department that displays departments having an average salary greater than 50,000.
create view top_salary_department as
select department,avg(salary) as avgsalary
from EMP
group by department
having avg(salary) > 50000;

select * from top_salary_department;

-- Q12. Create a View named employee_category_view that displays employee name, salary and salary category.
create view employee_category_view as
select emp_name,salary,
case 
when salary >=60000 then 'High salary'
when salary >=40000 then 'Medium salary'
else 'Low salary'
end as salary_category
from EMP;

select * from employee_category_view;

-- Q13. Create another View named it_salary_view using the existing it_employee_view. Display employee name and salary for employees earning more than 60,000.
create view it_salary_view as
select emp_name,salary
from it_employee_view
where salary > 60000;

select * from it_salary_view;

-- Q14. Update the definition of employee_details to include employee city also.
CREATE OR alter VIEW employee_details AS
SELECT emp_id, emp_name, department, city
FROM EMP;

select * from employee_details;

-- Q15. Delete the View named young_employee_view without deleting the original employees table.
drop view young_employee_view;