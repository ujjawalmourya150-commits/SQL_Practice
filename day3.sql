use sample3;

select *
from student_practise;

-- 1 .Display students whose marks are greater than 75 and whose age is greater than 20
select name
from student_practise
where marks>75 and age>20;

-- 2 . Display students who live in Pune or Mumbai and have marks greater than 80
select name
from student_practise
where city in ('Pune','Mumbai') and marks>80;

-- 3. Display students whose marks are between 65 and 90 but who do not live in Indore.
select name
from student_practise
where city!='Indore' and marks between 65 and 95;

-- 4 . Display students who live in Indore, Pune, or Mumbai and whose age is less than 22.
select name
from student_practise
where city in ('Indore','Pune','Mumbai') and age<22;

-- 5. Display students whose names start with A or end with a. Use LIKE.
select name
from student_practise
where name like 'A%'  or name like '%a';

-- 6. Display all students sorted by marks from highest to lowest
select name 
from student_practise
order by marks desc;

-- 7. Display all students sorted by city in ascending order and, within each city, by marks from highest to lowest
select name
from student_practise
order by city asc, marks desc;

-- 8. Display the top 3 students by marks, from highest to lowest.
select name 
from student_practise
order by marks desc
limit 3;

-- 9. Display students who do not live in Pune and whose marks are not between 70 and 90.
select name
from student_practise
where city!='pune' and marks not between 70 and 90;

-- 10. Display students who:
-- Are older than 20.
-- Have marks greater than 70.
-- Do not live in Mumbai.
-- Show only their names and marks, sorted by marks from highest to lowest.
select name,marks
from student_practise
where age>20 and marks>70 and city!='mumbai'
order by marks desc;






