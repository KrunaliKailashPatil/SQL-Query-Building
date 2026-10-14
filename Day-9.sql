CREATE TABLE hospital_patients
(
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    city VARCHAR(50),
    age INT
);

INSERT INTO hospital_patients VALUES
(1, 'Aarav', 'Pune', 25),
(2, 'Diya', 'Mumbai', 32),
(3, 'Kabir', 'Surat', 45),
(4, 'Meera', 'Pune', 28),
(5, 'Ishaan', 'Nashik', 60),
(6, 'Sara', 'Delhi', 35),
(7, 'Riya', 'Mumbai', 22);

CREATE TABLE hospital_doctors
(
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(50)
);

INSERT INTO hospital_doctors VALUES
(101, 'Dr. Sharma', 'Cardiology'),
(102, 'Dr. Patel', 'Orthopedics'),
(103, 'Dr. Khan', 'Dermatology'),
(104, 'Dr. Mehta', 'Neurology'),
(105, 'Dr. Joshi', 'Pediatrics');

CREATE TABLE hospital_appointments
(
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20)
);

INSERT INTO hospital_appointments VALUES
(201, 1, 101, '2026-10-01', 'Completed'),
(202, 2, 102, '2026-10-02', 'Completed'),
(203, 1, 101, '2026-10-05', 'Completed'),
(204, 3, 103, '2026-10-06', 'Cancelled'),
(205, 4, 102, '2026-10-07', 'Completed'),
(206, 5, 104, '2026-10-08', 'Pending'),
(207, 2, 103, '2026-10-09', 'Completed'),
(208, 6, 101, '2026-10-10', 'Completed');

CREATE TABLE hospital_bills
(
    bill_id INT PRIMARY KEY,
    appointment_id INT,
    bill_amount DECIMAL(10,2),
    payment_status VARCHAR(20)
);

INSERT INTO hospital_bills VALUES
(301, 201, 1500, 'Paid'),
(302, 202, 2000, 'Paid'),
(303, 203, 1800, 'Paid'),
(304, 204, 1200, 'Unpaid'),
(305, 205, 2000, 'Paid'),
(306, 207, 1000, 'Unpaid'),
(307, 208, 1500, 'Paid');

CREATE TABLE hospital_departments
(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO hospital_departments VALUES
(1, 'Heart Care', 'Pune'),
(2, 'Bone Care', 'Mumbai'),
(3, 'Skin Care', 'Delhi'),
(4, 'Brain Care', 'Nashik'),
(5, 'Child Care', 'Surat')

select * from hospital_patients;
select * from hospital_doctors;
select * from hospital_appointments;
select * from hospital_departments;

-- Question 1. Display patient names with their appointment details
select p.patient_name,a.appointment_id,a.appointment_date,a.status
from hospital_patients as p
inner join hospital_appointments as a
on p.patient_id = a.patient_id;

-- Question 2. Display all patients, including patients without appointments
select p.patient_name,p.city,a.appointment_id,a.status
from hospital_patients as p
left join hospital_appointments as a
on p.patient_id = a.patient_id;

-- Question 3. Find patients who have never booked an appointment
select p.patient_id,p.patient_name,p.city
from hospital_patients as p
left join hospital_appointments as a
on p.patient_id = a.patient_id
where a.appointment_id is null;

-- Question 4. Find doctors who have never received an appointment
select d.doctor_id,d.doctor_name,d.specialization
from hospital_doctors as d
left join hospital_appointments as a
on d.doctor_id = a.doctor_id
where a.appointment_id is null;

-- Question 5. Display every appointment and its bill, even when no bill exists
select a.appointment_id,a.status,b.bill_id,b.bill_amount,b.payment_status
from hospital_appointments as a
left join hospital_bills as b
on a.appointment_id = b.appointment_id;

-- Question 6. Display patient names with their unpaid bills
select p.patient_name,a.appointment_id,b.bill_amount,b.payment_status
from hospital_patients as p
inner join hospital_appointments as a
on p.patient_id = a.patient_id
inner join hospital_bills as b
on a.appointment_id = b.appointment_id
where b.payment_status = 'Unpaid';

-- Question 7. Count appointments for every doctor
select d.doctor_id,d.doctor_name,count(a.appointment_id) as total_appointments
from hospital_doctors as d
left join hospital_appointments as a
on d.doctor_id = a.doctor_id
group by d.doctor_id,d.doctor_name;

-- Question 8. Calculate the total bill amount for completed appointments for each patient
select p.patient_name,sum(b.bill_amount) as total_billed_amount
from hospital_patients as p
inner join hospital_appointments as a
on p.patient_id = a.patient_id
inner join hospital_bills as b
on a.appointment_id = b.appointment_id
where a.status = 'Completed'
group by p.patient_id,p.patient_name;

-- Question 9. Display all doctors and their appointments, including doctors without appointments
select d.doctor_name,d.doctor_id,a.appointment_id,a.appointment_date,a.status
from hospital_doctors as d
full outer join hospital_appointments as a
on d.doctor_id = a.doctor_id;

-- Question 10. Find patients who have more than one completed appointment
select p.patient_name,count(a.appointment_id) as completed_appointments
from hospital_patients as p
inner join hospital_appointments as a
on p.patient_id = a.patient_id
where a.status = 'Completed'
group by p.patient_id,p.patient_name
having count(a.appointment_id) > 1;