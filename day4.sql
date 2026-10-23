use sample3;

-- 1. Display the total marks of all students using SUM().
select sum(marks) as 'total_marks'
from student_practise;

-- 2. Calculate the average marks of all students using AVG().
select avg(marks) as 'Average_marks'
from student_practise;

-- 3. Display the highest and lowest marks using MAX() and MIN().
SELECT
MAX(marks) AS Maximum_marks,
MIN(marks) AS Minimum_marks
FROM student_practise;

-- 4. Count how many students belong to each city.
SELECT city, COUNT(*) AS total_students
FROM student_practise
GROUP BY city;

-- 5. Display each city and its average student marks.
select city,avg(marks)
from student_practise
group by city;

-- 6. Display each city and the highest marks scored by a student in that city.
select city,max(marks)
from student_practise
group by city;

-- 7. Display each city and the total marks of its students. Sort the results from highest total to lowest total.
select city,sum(marks) as Total_marks
from student_practise
group by city
order by Total_marks desc;

-- 8. Display only cities that have at least 3 students.
select city,count(*) as total_students
from student_practise
group by city
having count(*)>=3;

-- 9. Display cities where the average marks are greater than 80.
select city,avg(marks)
from student_practise
group by city
having avg(marks)>80;

-- 10. Display each city, the number of students, and the average marks. 
-- Include only cities with at least 2 students and an average above 75. Sort by average marks from highest to lowest.
select city,count(*),avg(marks)
from student_practise
group by city
having count(*)>=2 and avg(marks)>75
order by avg(marks) desc;


