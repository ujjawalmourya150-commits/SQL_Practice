-- 1. Display the city and number of students. Sort by student count from highest to lowest.
select city,count(*)
from student_practise
group by city
order by count(*) desc;

-- 2. Display each city and its average marks, rounded to 2 decimal places. Show only cities with an average above 75.
select city,round(avg(marks),2)
from student_practise
group by city
having avg(marks)>75;

-- 3. Display each city and its highest marks. Show only cities where the highest marks are greater than 80.
select city,max(marks)
from student_practise
group by city
having max(marks)>80;

-- 4. For each city, count students scoring above 75. Show only cities with at least 2 such students.
select city, COUNT(*) 
from student_practise
where marks > 75
group by city
having COUNT(*) >= 2;

-- 5. For each city, display the percentage of students scoring above 75, rounded to 2 decimal places.
select city,round(sum(case when marks>75 then 1 else 0 end)*100/count(*),2) as percentage_students
from student_practise
group by city;

-- 6. Display each city and its total marks. Include only cities whose total marks are greater than 200. 
-- Sort the total from highest to lowest.
select city,sum(marks)
from student_practise
group by city
having sum(marks)>200
order by sum(marks) desc;

-- 7. Display each city and its average marks, but include only cities whose average is greater than the average marks of all students.
select city,avg(marks)
from student_practise
group by city
having avg(marks)>(select avg(marks)
from student_practise);

-- 8. Display:
-- City
-- Number of students
-- Average marks
-- Highest marks
-- Total marks
-- Conditions:
-- At least 2 students in the city.
-- Average marks above 70.
-- Sort by average marks descending, then total marks descending.
select city,count(*),avg(marks),max(marks),sum(marks)
from student_practise
group by city
having count(*)>=2 and avg(marks)>70
order by avg(marks) desc,sum(marks) desc;

-- 9. Classify city performance.
-- Display each city and its average marks, plus a performance column:
-- Above Average if the city's average is greater than the overall average.
-- Below Average if it is less than the overall average.
-- Equal Average if both are equal.
select city,avg(marks),
case 
when avg(marks)>(select avg(marks) from student_practise) 
then 'above average'
when avg(marks)<(select avg(marks) from student_practise) 
then 'below average'
else ' Equal Average'
end as performance
from student_practise
group by city;

-- Q10. Find the highest-performing city or cities.
-- Display the city and its average marks. Return only the city or cities with the highest average marks.
select city, avg(marks) as average_marks
from student_practise
group by city
having avg(marks) = (
    select max(city_average)
    from (
        select avg(marks) as city_average
        from student_practise
        group by city
    ) as city_averages
);
