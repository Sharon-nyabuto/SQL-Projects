set search_path = nairobi_school;
select * from students;
select * from subjects;
select * from exam_results;

--Date & Time Functions(PostgreSQL) ( using: Nairobi_academy)
 -- 1)	Write a query to extract the birth year, birth month, and birth day from each student's date_of_birth as three separate columns. Show first_name alongside them.--come back about regexp- regexp is not the right thing to use here, as it is appropriate for messy data, our data is okay and correct, just the output is different
select first_name, date_of_birth,
extract(year from date_of_birth)::TEXT as year,
extract (month from date_of_birth) as month,		
extract (day from date_of_birth) as day
from students;

--2)	Write a query to show each student's full name, their date_of_birth, and their age in complete years. Order from oldest to youngest.- 
select concat(first_name,' ',last_name) as full_name, date_of_birth, 
extract (year from (age(current_date,date_of_birth))) as current_age
from students
order by current_age desc;

--3)	Write a query to display each exam date in this exact format: 'Friday, 15th March 2024'.. Call the column formatted_date.
select TO_CHAR(exam_date, 'Day,ddth Month YYYY') as Formatted_Date
from exam_results;
	--TO_CHAR is a function for formatting dates.Converts date, or time value to text according to a specified format. syntax 	TO_CHAR(date_value, 'format_pattern')

