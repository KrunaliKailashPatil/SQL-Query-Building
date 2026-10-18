CREATE TABLE accounts
(
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    account_type VARCHAR(20),
    balance INT
);

INSERT INTO accounts VALUES
(1, 'Aditi', 'Pune', 'Savings', 25000),
(2, 'Rohan', 'Mumbai', 'Current', 60000),
(3, 'Sneha', 'Delhi', 'Savings', 40000),
(4, 'Vikram', 'Pune', 'Current', 80000),
(5, 'Pooja', 'Surat', 'Savings', 15000),
(6, 'Arnav', 'Mumbai', 'Savings', 50000),
(7, 'Isha', 'Delhi', 'Current', 35000),
(8, 'Kunal', 'Surat', 'Savings', 70000);

CREATE TABLE transactions
(
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount INT,
    transaction_status VARCHAR(20)
);

INSERT INTO transactions VALUES
(101, 1, 'Deposit', 10000, 'Completed'),
(102, 2, 'Withdrawal', 5000, 'Completed'),
(103, 1, 'Withdrawal', 3000, 'Completed'),
(104, 3, 'Deposit', 15000, 'Pending'),
(105, 4, 'Deposit', 20000, 'Completed'),
(106, 5, 'Withdrawal', 4000, 'Failed'),
(107, 6, 'Deposit', 12000, 'Completed'),
(108, 2, 'Deposit', 8000, 'Pending'),
(109, 7, 'Withdrawal', 6000, 'Completed'),
(110, 8, 'Deposit', 25000, 'Completed'),
(111, 4, 'Withdrawal', 10000, 'Completed'),
(112, 3, 'Withdrawal', 2000, 'Completed');

CREATE TABLE branches
(
    branch_id INT PRIMARY KEY,
    branch_city VARCHAR(30),
    manager_name VARCHAR(50)
);

INSERT INTO branches VALUES
(201, 'Pune', 'Mr. Shah'),
(202, 'Mumbai', 'Ms. Desai'),
(203, 'Delhi', 'Mr. Verma'),
(204, 'Surat', 'Ms. Joshi'),
(205, 'Nashik', 'Mr. Patil');

SELECT * FROM accounts;
SELECT * FROM transactions;
SELECT * FROM branches;

-- Question 1 — Basic: Find accounts with a balance greater than the average balance.
select customer_name,balance
from accounts
where balance > (select avg(balance)
                 from accounts);

-- Question 2 — Basic: Find the customer with the highest account balance.
select customer_name,balance
from accounts
where balance = (select max(balance)
                 from accounts);

-- Question 3 — Basic: Find transactions with an amount greater than the average transaction amount.
select transaction_type,amount
from transactions
where amount > (select avg(amount)
                from transactions);

-- Question 4 — Basic: Find customers who live in the same city as Aditi.
select customer_name,city
from accounts
where city = (select city
              from accounts
              where customer_name = 'Aditi');

-- Question 5 — Basic: Find customers who have at least one completed transaction.
select customer_name,account_id
from accounts
where account_id in (select account_id
                     from transactions
                     where transaction_status = 'Completed');

-- Question 6 — Basic: Find customers who have no completed transactions.
select account_id,customer_name
from accounts
where account_id not in (select account_id
                         from transactions
                         where transaction_status = 'Completed');

-- Question 7 — Intermediate: Find customers whose balance is greater than the average balance of their own account type.
select a.customer_name,a.account_type,a.balance
from accounts as a
where a.balance > (select avg(a2.balance)
                  from accounts as a2
                  where a2.account_type = a.account_type);

-- Question 8 — Intermediate: Find customers whose balance is greater than the highest Savings account balance.
select customer_name,account_type,balance
from accounts
where balance > (select max(balance)
                 from accounts
                 where account_type = 'Savings');

-- Question 9 — Intermediate: Find customers whose balance is lower than the minimum Current account balance.
select customer_name,account_type,balance
from accounts
where balance < (select min(balance)
                 from accounts
                 where account_type = 'Current');

-- Question 10 — Intermediate: Find customers whose account balance is greater than the average balance of customers living in Pune.
select customer_name,city,balance
from accounts
where balance > (select avg(balance)
                 from accounts
                 where city = 'Pune');