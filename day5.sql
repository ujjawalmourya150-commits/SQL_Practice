-- 1. Display each city and the number of students living there.
select city,count(*)
from student_practise
group by city;

-- 2. Display each city and its average student marks, sorted from highest average to lowest.
select city,avg(marks)
from student_practise
group by city
order by avg(marks) desc;

-- 3. Display each city and its highest marks. Show only cities where the highest marks are greater than 80.
select city,max(marks)
from student_practise
group by city
having max(marks)>80;

-- 4. Cities with at least 3 students
-- Display each qualifying city and its student count.
select city,count(*)
from student_practise
group by city
having count(*)>=3;

-- 5. Display each city and its total marks. Show the city with the highest total first.
select city,sum(marks)
from student_practise
group by city
order by sum(marks) desc
limit 1;

-- 6. Display only cities whose average student marks are greater than 75.
select city,avg(marks)
from student_practise
group by city
having avg(marks)>75;

-- 7. For each city, count students whose marks are greater than 75.
select city,count(*)
from student_practise
where marks >75
group by city;

-- 8. Display each city and its total marks, but only when the total exceeds 200.
select city,sum(marks)
from student_practise
group by city
having sum(marks) > 200;

-- 9. Display the city, student count, and average marks for cities meeting both conditions -->
-- Cities with 2 or more students and average marks above 70
select city,count(*),avg(marks)
from student_practise
group by city
having count(*)>=2 and avg(marks)>70;

-- 10. Rank city performance by average marks
-- Display each city, its student count, average marks, highest marks, and total marks. 
-- Show only cities with at least 2 students and an average above 70. Sort by average marks from highest to lowest.
select city,count(*),avg(marks),max(marks),sum(marks)
from student_practise
group by city
having count(*)>=2 and avg(marks)>70
order by avg(marks) desc;


