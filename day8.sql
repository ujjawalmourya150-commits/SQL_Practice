-- DAY 8 - SQL PRACTICE
-- Topic: Subqueries, CASE WHEN, GROUP BY, HAVING, MAX and MIN
use sample3;
-- Q1. Display each city and its average marks.
-- Show only cities whose average marks are greater than
-- the overall average marks of all students.
-- Hint: GROUP BY, HAVING, and a subquery using AVG(marks).
select city,avg(marks)
from student_practise
group by city
having avg(marks)>(select avg(marks) from student_practise);

-- Q2. Display the names and marks of students who scored
-- more than the overall average marks of all students.
-- Hint: Use a subquery in WHERE.
select name,marks
from student_practise
where marks>(select avg(marks) from student_practise);

-- Q3. Display each city and its total marks.
-- Show only cities whose total marks are greater than
-- the average of the city totals.
-- Hint: Calculate the total marks for each city first,
-- then compare those totals with their average.
select city,sum(marks) as total_marks
from student_practise
group by city
having sum(marks)> (select avg(city_total)
from (
    select sum(marks) as city_total
    from student_practise
    group by city
) as city_totals
);


-- Q4. Display each city, its average marks, and a status.
-- Use these conditions:
-- Above Average: city average > overall average
-- Below Average: city average < overall average
-- Equal Average: city average = overall average
-- Hint: Use CASE WHEN and a subquery.
select city,avg(marks),
case
when avg(marks)>(select avg(marks) from student_practise)
then 'Above average'
when avg(marks)<(select avg(marks) from student_practise)
then 'Below average'
else 'Equal average'
end as status
from student_practise
group by city;

-- Q5. Display each student's name, marks, and a category.
-- Use these conditions:
-- Above Average: marks > overall average
-- Below Average: marks < overall average
-- Equal Average: marks = overall average
-- Hint: Use CASE WHEN with a subquery
select name,marks,
case
when marks>(select avg(marks) from student_practise)
then 'Above Average'
when marks<(select avg(marks) from student_practise)
then 'Below Average'
else 'Eqal Average'
end as category
from student_practise;

-- Q6. Display the city and its total marks.
-- Return only the city or cities with the highest total marks.
-- Hint: Use SUM(marks), GROUP BY, and a nested subquery.
select city,sum(marks)
from student_practise
group by city
having sum(marks)=(select max(city_total)
from (select sum(marks) as city_total
from student_practise
group by city) as city_totals
);

-- Q7. Display the city and its average marks.
-- Return only the city or cities with the lowest average marks.
-- Hint: Similar to finding the highest average, but use MIN()
-- instead of MAX().
select city,avg(marks)
from student_practise
group by city
having avg(marks)=(select min(avg_marks)
from (select avg(marks) as avg_marks
from student_practise
group by city) as average_marks);


-- Q8. Display the city and its average marks.
-- Return only the city or cities with the highest average marks.
-- Hint: Calculate the average for each city in an inner query,
-- then use MAX() to find the highest average.
select city,avg(marks)
from student_practise
group by city
having avg(marks)=(select max(avg_mark)
from (select avg(marks) as avg_mark
from student_practise
group by city) as avg_marks);


-- Q9. Display each city and its total marks.
-- Show only cities whose total marks are at least 80%
-- of the highest city total.
-- Hint: Use SUM(marks), a nested subquery with MAX(),
-- and multiplication by 0.80.
select city,sum(marks) as total_marks
from student_practise
group by city
having sum(marks)>= (
    select max(city_total) * 0.80
    from (
        select sum(marks) as city_total
        from student_practise
        group by city
    ) as city_totals
);

-- Q10. Display a city performance report with these columns:
-- city, student_count, average_marks, total_marks, performance.
-- Set performance to 'Above Average' if the city's average marks
-- are greater than the overall average; otherwise use
-- 'Average or Below'.
-- Show only cities with at least 2 students.
-- Sort by average marks from highest to lowest.
-- Hint: Combine GROUP BY, HAVING, CASE WHEN, a subquery,
-- and ORDER BY.
select city,count(*),avg(marks),sum(marks),
case
when avg(marks)>(select avg(marks) from student_practise)
then 'Above Average'
else 'Average or Below'
end as performance
from student_practise
group by city
having count(*)>=2
order by avg(marks) desc;
