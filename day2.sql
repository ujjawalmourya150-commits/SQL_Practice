use sample3;

create table student_practise(
name varchar(50),
age int,
marks int,
city varchar(50)
);

insert into student_practise (name,age,marks,city)
values ('Ujjawal', 20, 92, 'Indore'),
('Vedant', 22, 75, 'Pune'),
('Shubham', 22, 85, 'Mumbai'),
('Ayush', 21, 65, 'Indore'),
('Rahul', 20, 92, 'Pune'),
('Priya', 19, 88, 'Mumbai'),
('Aman', 23, 68, 'Indore'),
('Neha', 20, 78, 'Pune');

describe student_practise;

-- 1. Display all columns
select * 
from student_practise;

-- 2. Display students whose marks are greater than 80
select name
from student_practise
where marks>80;

-- 3. Display students whose age is less than or equal to 20
select name 
from student_practise
where age<=20;

-- 4 . Display students whose marks are greater than 75 and whose age is less than 22
select name 
from student_practise
where marks>75 and age<22;

-- 5 . Display students who live in Indore or Mumbai
select name 
from student_practise
where city='Indore' or city='Mumbai';

-- 6 . Display students who do not live in Pune
select name
from student_practise
where city!='Pune';

-- 7 . Display students whose marks are between 70 and 90, including both 70 and 90
select name 
from student_practise
where marks>=70 and marks<=90;

-- 8 . Display students whose city is either Pune, Indore, or Mumbai using IN
select name
from student_practise
where city in ('Indore','Mumbai','Pune');

-- 9. Display students who live in Pune and have marks greater than 75
select name
from student_practise
where city='Pune' and marks>75;

-- 10. Display students whose marks are not between 70 and 85
select name
from student_practise
where marks not between 70 and 85;
