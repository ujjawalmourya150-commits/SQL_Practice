-- DAY 9 - SQL PRACTICE
-- Topic: Nested Subqueries, CASE WHEN, GROUP BY, HAVING,
-- Conditional Aggregation, Percentages, MAX and MIN

USE sample3;
select * from student_practise;

-- Q1. Display each city and its average marks.
-- Show only cities whose average marks are greater than
-- the average of all city averages.
-- Hint: Use GROUP BY, HAVING, and a nested subquery.
select city ,avg(marks)
from student_practise
group by city
having avg(marks)>
(select avg(city_average) 
from (select avg(marks) as city_average 
from student_practise
group by city) as city_averages);

-- Q2. Display each city and its total marks.
-- Show only cities whose total marks are less than
-- the average of all city totals.
-- Display city and total_marks.
-- Hint: Calculate city totals first, then calculate their average.
select city,sum(marks) as total_marks
from student_practise
group by city
having sum(marks)<(select avg(city_total)
from (select sum(marks) as city_total
from student_practise
group by city)as city_totals);


-- Q3. Display each city and its average marks.
-- Return only the city or cities whose average marks are
-- the second-highest distinct city average.
-- If multiple cities share the second-highest average,
-- display all of them.
select city, avg(marks) as average_marks
from student_practise
group by city
having avg(marks) = (
    select distinct avg(marks)
    from student_practise
    group by city
    order by avg(marks) desc
    limit 1 offset 1
);

-- Q4. Display each city and its total marks.
-- Return only the city or cities whose total marks are
-- the second-lowest distinct city total.
-- If multiple cities share the second-lowest total,
-- display all of them.
select city,sum(marks) as total_marks
from student_practise
group by city
having sum(marks) = (select min(city_total) 
from (select sum(marks) as city_total 
from student_practise
group by city 
having sum(marks) > ((select min(city_total) 
from (select sum(marks) as city_total 
from student_practise
group by city) as city_totals)
)
)as lowest_totals);

-- Q5. Display each student's name, city, marks, and category.
-- Categories:
-- 'Topper' if marks are equal to the highest marks in the table.
-- 'Above Average' if marks are greater than the overall average
-- but lower than the highest marks.
-- 'Average or Below' otherwise.
select name,city,marks,
	case when marks=(select max(marks) from student_practise )
		then 'Topper'
    when marks > (select avg(marks) from student_practise) and marks < (select max(marks) from student_practise)
		then 'Above Average'
    else 'Average or Below'
    end as category
    from student_practise;
    

-- Q6. Display each city with these columns:
-- city, student_count, above_75_count, percentage_above_75.
-- Count students who scored more than 75 marks.
-- Calculate their percentage among all students in that city.
-- Round the percentage to 2 decimal places.
-- Show only cities where at least 50% of students scored
-- more than 75 marks.
select city,count(*) as student_count,
sum(case when marks>75 then 1 else 0 end) as above_75_count,
round(sum(case when marks>75 then 1 else 0 end) * 100.0 / count(*), 2 ) as percentage_above_75
from student_practise
group by city
having percentage_above_75 >= 50;


-- Q7. Display each city with its total marks and a performance label.
-- 'High' if the city's total marks are greater than
-- 80% of the highest city total.
-- 'Medium' if the city's total marks are greater than
-- 50% of the highest city total but not greater than 80%.
-- 'Low' otherwise.
select
    city,
    sum(marks) as total_marks,
    case
        when sum(marks) > (
            select max(city_total) * 0.80
            from (
                select sum(marks) as city_total
                from student_practise
                group by city
            ) as city_totals
        ) then 'high'

        when sum(marks) > (
            select max(city_total) * 0.50
            from (
                select sum(marks) as city_total
                from student_practise
                group by city
            ) as city_totals
        ) then 'medium'

        else 'low'
    end as performance_label
from student_practise
group by city;

-- Q8. Display each city and its average marks.
-- Show cities whose average marks are greater than the
-- average marks of students living in Indore.
-- Do not hardcode the average value.
select city,avg(marks) as average_marks
from student_practise
group by city
having avg(marks)>(select avg(marks) from student_practise where city='indore');
	
-- Q9. Display each city with these columns:
-- city, student_count, total_marks, average_marks.
-- Show only cities that satisfy BOTH conditions:
-- 1. At least 2 students live in the city.
-- 2. The city's total marks are greater than the overall
--    average marks of all individual students multiplied
--    by the number of students in that city.
select city,
       count(*) as student_count,
       sum(marks) as total_marks,
       avg(marks) as average_marks
from student_practise
group by city
having count(*) >= 2
and sum(marks) > (
    (select avg(marks) from student_practise) * count(*)
);

-- Q10. Create a city performance report with these columns:
-- city, student_count, average_marks, total_marks,
-- above_average_count, performance.
--
-- Requirements:
-- 1. Count students in each city.
-- 2. Calculate the city's average and total marks.
-- 3. Count students whose marks are greater than the overall
--    average marks.
-- 4. Set performance to 'Excellent' if the city's average
--    is greater than the overall average AND at least 50%
--    of its students scored above the overall average.
-- 5. Otherwise, set performance to 'Needs Improvement'.
-- 6. Show only cities with at least 2 students.
-- 7. Sort by average_marks from highest to lowest.
with city_report as
(
    select
        city,
        count(*) as student_count,
        avg(marks) as average_marks,
        sum(marks) as total_marks,

        sum(
            case
                when marks > (select avg(marks)
                              from student_practise)
                then 1
                else 0
            end
        ) as above_average_count

    from student_practise
    group by city
    having count(*) >= 2
)

select
    city,
    student_count,
    average_marks,
    total_marks,
    above_average_count,

    case
        when average_marks > (select avg(marks)
                              from student_practise)
        and above_average_count >= student_count * 0.50
        then 'excellent'
        else 'needs improvement'
    end as performance

from city_report
order by average_marks desc;