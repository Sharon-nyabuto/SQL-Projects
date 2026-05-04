
---Create a schema called nairobi_academy and make sure SQL is using it before you do anything else.
create schema nairobi_academy;

set search_path = nairobi_academy;

---Create the students table 
create table students
(student_id int primary key,
first_name VARCHAR(50) not null,
last_name VARCHAR(50) not null,
gender VARCHAR(1),
date_of_birth DATE, 
class VARCHAR(10), 
city VARCHAR(50) 
);

---Create the subjects table 
create table subjects
(subject_id int primary key,
subject_name VARCHAR(100) not null unique,
department VARCHAR(50),
teacher_name VARCHAR(100),
credit INT
);

---Create the table exam_results 
create table exam_results
(result_id int primary key,
student_id int references students (student_id),
subject_id int references subjects (subject_id),
marks int not null,
exam_date DATE,
grade VARCHAR(2)
);
select * from exam_results

---Add a column phone_number with data type VARCHAR(20).
alter table students 
add column phone_number VARCHAR(20);

---Rename column credits in the subjects to credit_hours. 
alter table subjects
rename column credit to credit_hours;
select * from subjects

---Remove column Phone_number.

alter table students
drop column Phone_Number;

select * from students

---SECTION B - Filling the Database (DML: INSERT, UPDATE, DELETE)
---Insert 10 students,10 subjects, 10 exam results.
insert into students (student_id,first_name,last_name,gender,date_of_birth,class,city)
values 
	(1,'Amina','Wanjiku','F','2008-03-12','Form 3','Nairobi'),
	(2,'Brian','Ochieng','M','2007-07-25','Form 4','Mombasa'),
	(3,'Cynthia','Mutua','F','2008-11-05','Form 3','Kisumu'),
	(4,'David','Kamau','M','2007-02-18','Form 4','Nairobi'),
	(5,'Esther','Akinyi','F','2009-06-30','Form 2','Nakuru'),
	(6,'Felix','Otieno','M','2009-09-14','Form 2','Eldoret'),
	(7,'Grace','Mwangi','F','2008-01-22','Form 3','Nairobi'),
	(8,'Hassan','Abdi','M','2007-04-09','Form 4','Mombasa'),
	(9,'Ivy','Chebet','F','2009-12-01','Form 2','Nakuru'),
	(10,'James','Kariuki','M','2008-08-17','Form 3','Nairobi');
select * from students

insert into subjects (subject_id,subject_name,department,teacher_name,credit_hours)
values 
	(1,'Mathematics','Sciences','Mr. Njoroge',4),
	(2,'English','Languages','Ms. Adhiambo',3),
	(3,'Biology','Sciences','Ms.Otieno',4),
	(4,'History','Humanities','Mr. Waweru',3),
	(5,'Kiswahili','Languages','Ms. Nduta',3),
	(6,'Physics','Sciences','Mr. Kamande',4),
	(7,'Geography','Humanities','Ms. Chebet',3),
	(8,'Chemistry','Sciences','Ms. Muthoni',4),
	(9,'Computer Studies','Sciences','Mr. Oduya',3),
	(10,'Business Studies','Humanities','Ms. Wangari',3);
select * from subjects

insert into exam_results (result_id,student_id,subject_id,marks,exam_date,grade)
values 
	(1,1,1,78,'2024-03-15','B'),
	(2,1,2,85,'2024-03-16','A'),
	(3,2,1,92,'2024-03-15','A'),
	(4,2,3,55,'2024-03-17','C'),
	(5,3,2,49,'2024-03-16','D'),
	(6,3,4,71,'2024-03-18','B'),
	(7,4,1,88,'2024-03-15','A'),
	(8,4,6,63,'2024-03-19','C'),
	(9,5,5,39,'2024-03-20','F'),
	(10,6,9,95,'2024-03-21','A');
select * from exam_results

---Esther Akinyi has moved from Nakuru to Nairobi. 
update students
set City = 'Nairobi'
where student_id = 5;

---The marks for result_id 5 were entered incorrectly - the correct marks are 59, not 49. Write an UPDATE to fix this.
update exam_results
set marks = 59
where result_id = 5;
select * from exam_results

---The exam result with result_id 2 has been cancelled by the school. Write a DELETE statement to remove it from the exam_results table.
  delete from exam_results
 where result_id = 2;
select * from exam_results

---SECTION C  Querying the Data (Filtering with WHERE)

---Write a query to find all students who are in Form 4.

select first_name,last_name,class
from students 
where class = 'Form 4';

---Write a query to find all subjects in the Sciences department.
select subject_name
from subjects 
where department = 'Sciences';

---Write a query to find all exam results where the marks are greater than or equal to 70.
select result_id,student_id,subject_id,marks,grade
from exam_results
where marks >= 70;

---Write a query to find all female students only. (Hint: gender = 'F')
select first_name,last_name
from students 
where gender = 'F';

---Write a query to find all students who are in Form 3 AND from Nairobi.
select first_name,last_name,city
from students 
where class = 'Form 3' and city = 'Nairobi';

---Write a query to find all students who are in Form 2 OR Form 4.
select first_name,last_name,class
from students 
where class = 'Form 3' or class = 'Form 4';

---Exam results where marks are between 50 and 80
select result_id,student_id,subject_id,marks,grade
from exam_results 
where marks between 50 and 80;

--- Exams that took place between 15th March 2024 and 18th March 2024
select result_id,student_id,subject_id,marks,grade
from exam_results 
where exam_date between '2024-03-15' and '2024-03-18';

---Students who live in Nairobi, Mombasa, or Kisumu - use IN.
select first_name,last_name,class
from students 
where city in ('Nairobi','Mombasa','Kisumu');

---Students who are NOT in Form 2 or Form 3 - use NOT IN.
select first_name,last_name,class
from students 
where class not in ('Form 2','Form 3');

---Students whose first name starts with the letter 'A' or 'E'
select first_name
from students
where first_name like 'A%'or first_name like 'E%';

---Subjects whose subject name contains the word 'Studies'.
select subject_name
from subjects
where subject_name like '%Studies%';

---SECTION B - COUNT
---How many students are currently in Form 3
select count(*) as Form_3_students
from students
where class = 'Form 3';

---How many exam results have a mark of 70 or above?
select count(*) as Over_70
from exam_results
where marks >= 70;

---Write a query using CASE WHEN 

select result_id, student_id, subject_id,marks,
	case
		when marks >= 80 then 'Distinction'
		when marks >= 60 then 'Merit'
		when marks >= 40 then 'Pass'
		else 'Fail'
	end as Performance
from exam_results;


	select first_name, last_name,class,
	case 
		when class in ('Form 3','Form 4') then 'Senior'
		else 'Junior'
	end as Student_Level
from students;

---Students whose gender is NOT male 
select first_name,last_name,class
from students
where gender!= 'M';

---Results where marks are greater than 60 AND less than 90.
select result_id,student_id,subject_id,marks,grade
from exam_results 
where marks >60 and marks <90;

--- subjects that are NOT in the Sciences department.
select subject_name
from subjects 
where department not in  ('Sciences');

---students born between 1st January 2008 and 31st December 2008.
select first_name, last_name, date_of_birth
from students 
where date_of_birth between '2008-01-01' and '2008-12-31';

---subjects that belong to Languages or Humanities
select subject_name, department
from subjects 
where department in ('Languages','Humanities');

---students whose last name ends with 'u'.
select first_name,last_name
from students
where last_name like '%u';

---teachers whose name starts with 'Ms'.
select teacher_name
from subjects
where teacher_name like 'Ms.%';

---How many students are there in total?
select count(*) as Student_number
from students 

---How many subjects are in the Sciences department?
select count(*) as Sciences_Subjects
from subjects
where department = 'Sciences';

---How many students come from Nairobi?
select count(*) as Students_from_Nairobi
from students
where city = 'Nairobi';


select *,
	case
		when marks >= 90 then 'Excellent'
		when marks >= 70 then 'Good'
		when marks >= 50 then 'Average'
		else 'Poor'
	end as Grade_categories
from exam_results;

select subject_name,department,
	case 
		when department = 'Sciences' then 'STEM'
		else 'Arts'
	end as department_group
from subjects;

---subjects whose teacher's name starts with 'Ms' AND the subject is in the Sciences department.
select subject_name
from subjects
where teacher_name like 'Ms.%' and department = 'Sciences';

---Shows each student's full name (first + last joined together), their class, and a CASE WHEN label - 'Senior' if Form 3 or Form 4, 'Junior' otherwise.
select concat(first_name,' ',last_name), class, 
case
	when class in ('Form 3','Form 4') then 'Senior'
	else 'Junior'
end as class_label
from students;

---students NOT from Nairobi who were born after 1st January 2008, and display their names in UPPERCASE.
select upper(concat(s.first_name,' ',last_name)) from students s 
where city not in ('Nairobi') and s.date_of_birth > '2008-01-01';

