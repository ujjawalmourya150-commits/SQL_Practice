create database sample3;

use sample3;

-- Creating table
create table students(
s_name char(15),
s_id int,
s_age int,
s_dob date
);

show tables;

describe students;

insert into students(
s_name,s_id,s_age,s_dob
)
values
('ujjawal',1,20,'2006-01-05'),
('vedant',2,22,'2004-01-05'),
('shubham',3,22,'2004-02-24'),
('Ayush',4,21,'2005-06-06');

-- 1 .Display all students 
select * from students;

-- 2 .Display only the name and s_id columns 
select s_name,s_id from students;

-- 3 . Display the names of students who's age is 20
select s_name
from students
where s_age=20;

-- 4 . Display all details of students who's age is more than 20
select *
from students
where s_age>20;

-- 5 . Display all details of students who's age is more than 21
select * 
from students
where s_age>21;

-- 6 . Display all details of students whose DOB is exactly 2006-01-05
select *
from students
where s_dob="2006-01-05";

-- 7 . sum of age of all students
select sum(s_age) as 'Total age'
from students;

-- 8 .  Names ending with 'u'
select s_name
from students
where s_name like 'u%';

-- 9 . Names ending with 'l'
select s_name
from students
where s_name like '%l';

-- 10 . Names containing 'yu'
select s_name
from students
where s_name like '%yu%';
