CREATE TABLE sq_students
(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    course VARCHAR(30),
    city VARCHAR(30),
    age INT
);

INSERT INTO sq_students VALUES
(1, 'Anjali', 'Python', 'Pune', 21),
(2, 'Rahul', 'SQL', 'Mumbai', 22),
(3, 'Meera', 'Python', 'Surat', 20),
(4, 'Dev', 'Power BI', 'Pune', 23),
(5, 'Ishita', 'SQL', 'Delhi', 21),
(6, 'Karan', 'Python', 'Mumbai', 24),
(7, 'Priti', 'Power BI', 'Surat', 22),
(8, 'Aman', 'SQL', 'Pune', 20);

CREATE TABLE sq_exam_results
(
    result_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(30),
    marks INT,
    exam_status VARCHAR(20)
);

INSERT INTO sq_exam_results VALUES
(101, 1, 'Python', 85, 'Passed'),
(102, 2, 'SQL', 72, 'Passed'),
(103, 3, 'Python', 91, 'Passed'),
(104, 4, 'Power BI', 65, 'Passed'),
(105, 5, 'SQL', 48, 'Failed'),
(106, 1, 'SQL', 78, 'Passed'),
(107, 6, 'Python', 55, 'Passed'),
(108, 7, 'Power BI', 88, 'Passed'),
(109, 8, 'SQL', 35, 'Failed'),
(110, 3, 'SQL', 82, 'Passed'),
(111, 4, 'Excel', 45, 'Failed'),
(112, 6, 'SQL', 67, 'Passed'),
(113, 2, 'Excel', 90, 'Passed'),
(114, 5, 'Excel', 76, 'Passed');

CREATE TABLE sq_courses
(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(30),
    course_fee INT
);

INSERT INTO sq_courses VALUES
(201, 'Python', 8000),
(202, 'SQL', 6000),
(203, 'Power BI', 7500),
(204, 'Excel', 4000),
(205, 'Statistics', 5000);

SELECT * FROM sq_students;
SELECT * FROM sq_exam_results;
SELECT * FROM sq_courses;

-- Question 1 — Find students who scored more than the average marks across all exam records.
select student_id,subject,marks
from sq_exam_results
where marks > (select avg(marks)
               from sq_exam_results);

-- Question 2 — Find the student who scored the highest marks in any exam.
select s.student_name,r.subject,r.marks
from sq_students as s
inner join sq_exam_results as r
on s.student_id = r.student_id
where r.marks = (select max(marks)
                 from sq_exam_results);

-- Question 3 — Find students who scored below the average marks in SQL.
select s.student_name,r.subject,r.marks
from sq_students as s
inner join sq_exam_results as r
on s.student_id = r.student_id
where r.subject = 'SQL'
and r.marks < (select avg(marks)
               from sq_exam_results
               where subject = 'SQL');

-- Question 4 — Find the highest-scoring student in each subject.
select s.student_name,r.marks,r.subject
from sq_students as s
inner join sq_exam_results as r
on s.student_id = r.student_id
where r.marks = (select max(r2.marks)
                 from sq_exam_results as r2
                 where r2.subject = r.subject);

-- Question 5 — Find students who scored above their own average marks.
select s.student_name,r.subject,r.marks
from sq_students as s
inner join sq_exam_results as r
on s.student_id=r.student_id
where r.marks > (select avg(r2.marks)
                 from sq_exam_results as r2
                 where r2.student_id = r.student_id);

-- Question 6 — Find students who have passed at least one exam using EXISTS.
select s.student_name,s.student_id
from sq_students as s
where exists ( select 1
               from sq_exam_results as r
               where r.student_id = s.student_id
               and r.exam_status = 'Passed');

-- Question 7 — Find students who have no failed exams.
select s.student_id,s.student_name
from sq_students as s
where not exists (select 1
                  from sq_exam_results as r
                  where r.student_id=s.student_id
                  and r.exam_status = 'Failed');

-- Question 8 — Find courses with fees greater than the average course fee.
select course_name,course_fee
from sq_courses
where course_fee > (select avg(course_fee)
                    from sq_courses);

-- Question 9 — Find the course with the highest fee.
select course_name,course_fee
from sq_courses
where course_fee = (select max(course_fee)
                    from sq_courses);

-- Question 10 — Find students enrolled in courses whose fee is above the average course fee.
select student_name,course
from sq_students
where course in (select course_name
                 from sq_courses
                 where course_fee > (select avg(course_fee)
                                     from sq_courses));