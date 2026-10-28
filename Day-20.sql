CREATE TABLE StudentResults
(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    subject VARCHAR(30),
    marks INT,
    city VARCHAR(30),
    exam_status VARCHAR(20)
);

INSERT INTO StudentResults VALUES
(1, 'Anaya', 'SQL', 85, 'Pune', 'Pass'),
(2, 'Vivan', 'Python', 72, 'Mumbai', 'Pass'),
(3, 'Riya', 'SQL', 45, 'Pune', 'Fail'),
(4, 'Aryan', 'Python', 91, 'Delhi', 'Pass'),
(5, 'Diya', 'Excel', 68, 'Mumbai', 'Pass'),
(6, 'Ishaan', 'SQL', 55, 'Delhi', 'Pass'),
(7, 'Myra', 'Excel', 38, 'Pune', 'Fail'),
(8, 'Reyansh', 'Python', 80, 'Mumbai', 'Pass'),
(9, 'Kiara', 'Excel', 95, 'Delhi', 'Pass'),
(10, 'Advik', 'SQL', 62, 'Mumbai', 'Pass');

select * from StudentResults;

-- Question 1: Display unique subjects
with unique_sub as
(
select distinct(subject)
from StudentResults
)
select * from unique_sub;

-- Question 2: Assign a performance label to each student
with grade as
(
select student_name,marks,
case
when marks >= 80 then 'Excellent'
when marks >= 60 then 'Good'
when marks >= 40 then 'Avgrage'
else 'Poor'
end as performane
from StudentResults
)
select * from grade;

-- Question 3: Find the highest marks in each subject
with highest_marks as
(
select subject,max(marks) as highest_mark
from StudentResults
group by subject
)
select * from highest_marks;

-- Question 4: Display students who failed
with fail as
(
select * from StudentResults
where exam_status = 'Fail'
)
select * from fail;

-- Question 5: Count pass and fail students
with passfail as
(
select exam_status,count(*) as total_student
from StudentResults
group by exam_status
)
select * from passfail;

-- Question 6: Calculate average marks for each subject
with avg_marks as
(
select subject,avg(marks) as avgrage_marks
from StudentResults
group by subject
)
select * from avg_marks;

-- Question 7: Find students whose names start with A
with start_with_a as
(
select student_name, marks
from StudentResults
where student_name like 'A%'
)
select * from start_with_a;

-- Question 8: Find the top 3 students by marks
with top_3 as
(
select TOP 3 *
from StudentResults
order by marks desc
)
select * from top_3;

-- Question 9: Find students who scored above 80 marks
with above as 
(
select student_name,marks
from StudentResults
where marks > 80
)
select * from above;

-- Question 10: Display students from Mumbai
with mumbai as 
(
select student_name,marks,city
from StudentResults
where city = 'Mumbai'
)
select * from mumbai;