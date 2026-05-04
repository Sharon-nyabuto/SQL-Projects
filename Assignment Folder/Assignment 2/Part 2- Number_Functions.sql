set search_path = nairobi_school;
select * from students;
select * from subjects;
select * from exam_results;

--Number Functions
--1)	Write a query to show each exam result alongside the mark rounded to 1 decimal place, the mark rounded UP to the nearest 10 using CEIL, and the mark rounded DOWN using FLOOR. - Need to re-visit this
SELECT first_name, last_name, marks,
  	ROUND(marks, 1) AS rounded_1dp,--postgres automatically hides the 0 after a decimal point for an integer
    CEIL(marks / 10.0) * 10 AS rounded_up_10,
	FLOOR(marks / 10.0) * 10 AS rounded_down_10
FROM exam_results;

 SELECT first_name, last_name, marks,
  	ROUND(cast(marks, 1) AS rounded_1dp,--postgres automatically hides the 0 after a decimal point for an integer
    CEIL(marks / 10.0) * 10 AS rounded_up_10,
	FLOOR(marks / 10.0) * 10 AS rounded_down_10
FROM exam_results;
--Used 10.0 and not 10 to avoid integer division in postgres

--2)	Write a query to calculate the following summary statistics for exam_results in one query: total number of results (COUNT), average mark (AVG rounded to 2 decimal places), highest mark (MAX), lowest mark (MIN), and total marks added together (SUM).

select * from students;

select count(result_id) as number_of_results,
round(avg(marks),2) as average_mark, 
max(marks) as maximum_mark, 
min(marks) as minimum_mark,
sum(marks) as total_marks
from exam_results;

--3)	The school wants to apply a 10% bonus to all marks. Write a query to show each result_id, the original marks, and the new boosted_mark rounded to the nearest whole number.

select result_id,marks, round(((1 + 0.1)* marks),0) as new_boosted_mark
from exam_results;
