USE sample3;

-- DAY 10 - SQL PRACTICE
-- Topic: GROUP BY, HAVING, CASE WHEN, Subqueries,
-- Conditional Aggregation and Nested Subqueries.

select * from student_practise;

-- Q1. Display each city with these columns:
-- city, student_count, average_marks.
-- Sort by average_marks from highest to lowest.

select city ,count(*) as Student_count ,avg(marks) as Average_marks
from student_practise
group by city
order by Average_marks desc;

-- Q2. Display each city and its average marks.
-- Show only cities whose average marks are greater than 75.
-- Round average_marks to 2 decimal places.

select city, round(avg(marks),2) as Average_marks
from student_practise
group by city
having avg(marks) > 75;


-- Q3. Display the name, city and marks of students
-- who scored more than the overall average marks.
-- Sort marks from highest to lowest.

select name,city,marks
from student_practise
where marks > (select avg(marks) as Average_marks
from student_practise)
order by marks desc;

-- Q4. Display each city and its average marks.
-- Show only cities whose average marks are greater
-- than the average marks of students living in Indore.
-- Do not hardcode the average value.

select city,avg(marks) as Average_marks
from student_practise
group by city
having avg(marks) > (select avg(marks) as Average_marks
from student_practise
where city='indore');

-- Q5. Display each city with these columns:
-- city, total_marks, student_count.
-- Show only cities whose total marks are greater
-- than 200.
-- Sort total_marks from highest to lowest.

select city,sum(marks) as Total_marks, count(*) as Student_count
from student_practise
group by city
having Total_marks > 200
order by Total_marks desc;

-- Q6. Display each city with these columns:
-- city, student_count, above_75_count, percentage_above_75.
-- Count students who scored more than 75 marks.
-- Calculate the percentage of such students in each city.
-- Round percentage to 2 decimal places.
-- Show only cities where at least 50% of students
-- scored more than 75 marks.

select city,count(*) as student_count,
sum(case when marks > 75 then 1 else 0 end )as above_75_count,
round(sum(case when marks > 75 then 1 else 0 end )*100/count(*),2) as percenatge_above_75
from student_practise
group by city
having percenatge_above_75 >= 50;

-- Q7. Display each student's name, marks and category.
-- Use these conditions:
-- 'Excellent' if marks are greater than 85.
-- 'Good' if marks are greater than 75 but not greater than 85.
-- 'Needs Improvement' otherwise.

select name,marks,
case when marks>85 then 'Excellent'
when marks>75 and marks<=85 then 'Good'
else 'Needs Improvement'
end as category
from student_practise;

-- Q8. Display the city and its total marks.
-- Return only the city or cities with the highest
-- total marks.
-- If multiple cities have the same highest total,
-- display all of them.

select city,sum(marks) as total_marks
from student_practise
group by city
having total_marks= (
select max(city_total) from (select sum(marks) as city_total
from student_practise
group by city) as temp);

-- Q9. Display each city with these columns:
-- city, student_count, average_marks, above_average_count.
-- Count students whose marks are greater than
-- the overall average marks.
-- Show only cities with at least 2 students.
-- Sort by above_average_count from highest to lowest.

select city,count(*) as student_count,round(avg(marks),2) as Average_marks,
sum(case when marks>(select avg(marks) from student_practise)
then 1
else 0
end ) as above_average_count
from student_practise
group by city
having count(*) >= 2
order by above_average_count desc;
             
-- Q10. Create a city performance report with:
-- city, student_count, average_marks, total_marks,
-- percentage_above_75, performance.
-- Requirements:
-- 1. Calculate the number of students in each city.
-- 2. Calculate average and total marks.
-- 3. Calculate the percentage of students scoring above 75.
-- 4. Set performance to 'Excellent' if:
--    City's average marks are greater than 75 AND
--    at least 50% of students scored above 75.
-- 5. Otherwise, set performance to 'Average'.
-- 6. Show only cities with at least 2 students.
-- 7. Sort by average_marks from highest to lowest.

select
    city,
    count(*) as student_count,
    avg(marks) as average_marks,
    sum(marks) as total_marks,
    round(
        sum(case when marks > 75 then 1 else 0 end)
        * 100.0 / count(*), 2
    ) as percentage_above_75,
    case
        when avg(marks) > 75
        and sum(case when marks > 75 then 1 else 0 end)
            * 100.0 / count(*) >= 50
        then 'excellent'
        else 'average'
    end as performance
from student_practise
group by city
having count(*) >= 2
order by average_marks desc;