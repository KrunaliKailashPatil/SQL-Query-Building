CREATE TABLE training_results
(
    trainee_id INT PRIMARY KEY,
    trainee_name VARCHAR(30),
    course VARCHAR(30),
    batch_no INT,
    test_score INT,
    stipend INT
);

INSERT INTO training_results VALUES
(101, 'Asha',  'Data Analytics', 1, 82, 12000),
(102, 'Rohan', 'SQL',            1, 75, 10000),
(103, 'Meera', 'Data Analytics', 2, 91, 15000),
(104, 'Kunal', 'Python',         2, 68,  9000),
(105, 'Priya', 'SQL',            2, 88, 13000),
(106, 'Dev',   'Python',         3, 79, 11000),
(107, 'Isha',  'Data Analytics', 3, 85, 14000),
(108, 'Aman',  'SQL',            3, 72,  9500);

SELECT * FROM training_results;

-- Question 1 — Compare each trainee's stipend with Asha's stipend
select trainee_name,stipend,stipend - (select stipend
                                       from training_results
                                       where trainee_name = 'Asha')
                                       as [stipend difference]

from training_results;

-- Question 2 — Find trainees earning more than at least one Batch 1 trainee
select trainee_name,batch_no,stipend
from training_results
where stipend > any (select stipend
                     from training_results
                     where batch_no = 1);

-- Question 3 — Find trainees earning less than every Data Analytics trainee
select trainee_name,stipend
from training_results
where stipend < all (select stipend
                     from training_results
                     where course = 'Data Analytics');

-- Question 4 — Find everyone in the same batch as the trainee scoring 91
select *
from training_results
where batch_no = (select batch_no
                  from training_results
                  where test_score = 91);

-- Question 5 — Find trainees whose test score plus 5 is greater than Priya's test score.
select * 
from training_results
where test_score + 5 > (select test_score
                        from training_results
                        where trainee_name = 'priya');

-- Question 6 — Find trainees with a stipend equal to a Batch 2 stipend
select * 
from training_results
where stipend = ANY (select stipend
                 from training_results
                 where batch_no = 2);

-- Question 7 — Find trainees whose scores are lower than every Data Analytics score
select *
from training_results
where test_score < All(select test_score
                    from training_results
                    where course = 'Data Analytics');

-- Question 8 — Find trainees whose stipend is greater than the stipend of a Python trainee
select *
from training_results
where stipend > All (select stipend
                     from training_results
                     where course = 'Python');

-- Question 9 — Display every trainee with the number of Batch 2 trainees
select *,
(select count(*)
from training_results
where batch_no = 2)
AS batch_2_total
from training_results;

-- Question 10 — Find trainees who scored higher than the lowest-scoring Batch 3 trainee
select *
from training_results
where test_score > all (select min(test_score)
                        from training_results
                        where batch_no = 3);