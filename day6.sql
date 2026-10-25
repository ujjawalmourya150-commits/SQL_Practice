use sample3;

-- Q1. Display each city and its total number of students.
-- Sort cities alphabetically.
select city,count(*) as total_student
from student_practise
group by city
order by city ;

-- Q2. Display each city and its average marks.
-- Show the average rounded to 2 decimal places.
-- Sort from highest average to lowest.
select city,ROUND(AVG(marks), 2) as average_marks
from student_practise
group by city
order by average_marks desc;

-- Q3. Display each city and its total marks.
-- Show only cities where total marks are greater than 200.
select city,sum(marks) as total_marks
from student_practise
group by city
having total_marks > 200;

-- Q4. For each city, count students whose marks are greater than 80.
-- Show only cities having at least 2 such students.
select city,count(*)
from student_practise
where marks>80
group by city
having count(*)>=2;

-- Q5. Display each city, its highest marks, and lowest marks.
-- Show only cities where the difference between highest and lowest
-- marks is greater than 15.
select city,max(marks),min(marks)
from student_practise
group by city
having max(marks)-min(marks)>15;

-- Q6. Display cities where the average marks are greater than 75
-- and the number of students is at least 2.
-- Sort by average marks from highest to lowest.
select city,avg(marks),count(*)
from student_practise
group by city
having count(*)>=2 and avg(marks)>75
order by avg(marks) desc;

-- Q7. Find the city with the lowest average marks.
-- Display the city and its average marks.
select city,avg(marks)
from student_practise
group by city
order by avg(marks)
limit 1 ;

-- Q8. Display each city and its percentage of students scoring
-- more than 75 marks.
-- Show the percentage rounded to 2 decimal places.
-- Hint: Use SUM(CASE WHEN ... THEN 1 ELSE 0 END) and COUNT(*).
SELECT city,ROUND(SUM(CASE WHEN marks > 75 THEN 1 ELSE 0 END)* 100.0 / COUNT(*),2) AS percentage_students
FROM student_practise
GROUP BY city;

-- Q9. Display each city where the total marks are greater than
-- the overall average marks of all individual students.
-- Show the city and its total marks.
SELECT city, SUM(marks) AS total_marks
FROM student_practise
GROUP BY city
HAVING SUM(marks) > (
    SELECT AVG(marks)
    FROM student_practise
);

-- Q10. Create a city performance report showing:
-- 1. City
-- 2. Number of students
-- 3. Average marks
-- 4. Highest marks
-- 5. Total marks
-- Include only cities having at least 2 students
-- and average marks above 70.
-- Sort by average marks descending, then total marks descending.
select city,count(*),avg(marks),max(marks),sum(marks)
from student_practise
group by city
having count(*)>=2 and avg(marks)>70
ORDER BY AVG(marks) DESC, SUM(marks) DESC;
