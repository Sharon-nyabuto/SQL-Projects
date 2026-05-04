
Applying SQL Concepts: DDL, DML, Filtering, and Data Transformation

**Structured Query Language (SQL)** is the standard language used to interact with relational databases. 
SQL is a command type language. Whether you want to create, delete, update or read data, SQL provides commands to perform these operations. 
SQL commands are categorized based on their **specific functionalities**, and allow for the creation, manipulation, retrieval and control of data and database structures.
Among the command categories include; 

- Data Definition Language (DDL)
- Data Manipulation Language (DML)
- Data Query Language (DQL)
- Data Control Language (DCL)
- Transaction Control Language (TCL)

In this article, we will look at Data Definition Language (DDL) and Data Manipulation Language (DML).

## <u>DDL (DATA DEFINITION LANGUAGE)</u>

Data Definition Language (DDL) is a set of commands used to **define** and **manage** the _structure_ of a database. 
It focuses on creating and modifying database objects such as tables, schemas, and indexes. 
DDL uses commands like **_CREATE,_** **_ALTER,_** and **_DROP,_** to determine how data is organized and stored within the database. 
These commands affect the **structure** of the database and not the data itself. 
DDL operations are often automatically committed, therefore changes take effect immediately without needing a manual _COMMIT_.

## <u>DML (DATA MANIPULATION LANGUAGE)</u>

Data Manipulation Language (DDL) is a set of SQL commands used to **manage** and **manipulate** the _data _stored within database tables. 
Unlike DDL, which focuses on defining the structure of the database, DML is concerned with performing operations on the **data** itself. 
Common DML commands include **INSERT,**_ **_UPDATE_,** and **_DELETE_,** which are used to add new records, modify existing data, and remove records from a table respectively. 
In most database systems, DML changes are not automatically committed, meaning they can be rolled back if necessary before being finalized.

---

**Below are some SQL commands and how they are used;**

**_CREATE_**
DDL command used to create an object in a database, e.g a table

The syntax; 
CREATE TABLE table_name(
column1 datatype constraints,
column2 datatype constraints,
column3 datatype constraints
);
For example, to create a schema in a database for a school, and add a table called _students_ in the Schema you use _CREATE_

```sql
create table students
(student_id INT primary key,
first_name VARCHAR(50) not null,
last_name VARCHAR(50) not null,
gender VARCHAR(1),
date_of_birth DATE, 
class VARCHAR(10), 
city VARCHAR(50) 
);
```

![Table _students_ Created](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/2cnzby37arrc0hxvlm0l.png)


**_INSERT_**

This command is used to add a new record in a database.

The syntax;
INSERT INTO table_name (column1, column2, column3)
VALUES 
(value1, value2, value3),
(value1, value2, value3);

To add student details to the students table created above, you use _INSERT_

```sql
insert into students (student_id,first_name,last_name,gender,date_of_birth,class,city)
values 
(1,'Amina','Wanjiku','F','2008-03-12','Form 3','Nairobi'),
(2,'Brian','Ochieng','M','2007-07-25','Form 4','Mombasa'),
(3,'Cynthia','Mutua','F','2008-11-05','Form 3','Kisumu'),
(4,'David','Kamau','M','2007-02-18','Form 4','Nairobi'),
(5,'Esther','Akinyi','F','2009-06-30','Form 2','Nakuru');
```

![_students_ table populated with student information](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/l5oca738folscqftezfe.png)

_**UPDATE**_
The update command is used to modify existing records in a database. 

The syntax;
UPDATE table_name
SET column1 = value1,
WHERE condition;
 
In the students table created, if student id number 2, moved to Nairobi from Mombasa, _UPDATE_ is used.

```sql
update students
set City = 'Nairobi'
where student_id = 2;

```
![Result after city update](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/v7b6tqzq5dhlhtegy1cf.png)

**_DELETE_**

This deletes one or more records from a database object. 
It is used together with the _WHERE _clause to ensure that only specific rows are deleted.

The syntax;

DELETE FROM table_name
WHERE condition;

In the students table, if student_id 4 is no longer a student there, his records are removed using _DELETE_

```sql
delete 
from students
 where student_id = 4;
```


![_students_ table with one record removed](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/tbq8aw39rovam6uyq494.png)

---

## <u>FILTERING WITH WHERE</u>

The **WHERE** clause filters rows based on one or more conditions, so your query only modifies the records that match. 
It is often used across **SELECT,** **UPDATE,** and **DELETE** statements.

The Where clause is used with logical and comparison operators such as equal to **(=)**, greater than **(>)** and less than **(<)**.

It can also be used with other operators including;

**BETWEEN**

Where clause is used with the _BETWEEN_ operator, to filter records within a specified range.
When using between, the result will include both the start and end values of the range.

For example, to find students that scored between 55 and 95 marks from a results table, the values returned will include _55_ and _95_

```sql
select result_id,student_id,subject_id,marks,grade
from exam_results 
where marks between 55 and 95;
```

![Where clause used with Between ](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/3xk2s9wghusj0dpcyw3m.png)

**IN**

The **WHERE** clause can be used with the _IN_ operator to filter records based on multiple values. 
It makes queries shorter and easier to understand, instead of writing multiple conditions using the (=) operator combined with OR.

Syntax;
 
SELECT column1, column2
FROM table_name
WHERE column_name IN (value1, value2, value3);

To find students from different cities in our students table, we use _IN_

```sql
select first_name, last_name, city
from students 
where city in ('Nairobi','Nakuru','Mombasa');
```

![IN operator filtering our different cities](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xfuhnzi5d2s6y36vrbe4.png)

**LIKE**

 **WHERE** clause is used with the **LIKE** operator when searching for a particular pattern. 
When using _LIKE_, a wildcard is used; 
**‘%’**- signifies any number of characters including 0.
 **‘_’** wildcard is used for a specific number of characters.

Syntax is;
SELECT column_name
FROM table_name
WHERE column_name LIKE 'pattern';

For example, to find the list of subjects that contain the word 'studies' in a subjects table, _LIKE_ is used.

```sql
select subject_name
from subjects
where subject_name like '%Studies%';
```

![Filtering using _Where_ clause and Like](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/5udywjq3i6e2u04uq0fc.png)

---

## CASE WHEN STATEMENT

The **CASE WHEN** statement is used to add conditional logic inside queries, similar to an _if-else_ structure.
It checks conditions one by one and returns a value as soon as a matching condition is found.
It helps categorize data dynamically and allows creation of new categories based on the specific conditions within a query.

The syntax is;

select column name, 
   case
     when condition1 then 'result 1'
     when condition2 then 'result 2'
    else 'default result
 end as new column_name 

For example, **CASE WHEN** can be used to group marks into a new column called Performance, in the results table, as shown below.

```sql
select result_id, student_id, subject_id,marks,
	case
		when marks >= 80 then 'Distinction'
		when marks >= 60 then 'Merit'
		when marks >= 40 then 'Pass'
		else 'Fail'
	end as Performance
from exam_results;
```

![Case When statement](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ey0dt701fcwyrux0jkjq.png)

---

## REFLECTION 
Learning Databases and SQL can seem difficult, but once you get into it, it becomes interesting especially if you are curious to see how you can create and modify your database along the way. 

The most interesting thing with SQL is that there are some rules for consistency and functionality across databases. Some of those rules are; 

- Always end your statements with a semicolon (;) 

- SQL commands and key words such as SELECT and INSERT are not case-sensitive.
- Spaces and new lines are allowed for better readability.
- Do not use SQL keywords as names, if you have to, write them in quotes.
- To include comments in your script, begin single line comments with --- and for multi-line comments you use /* at the beginning and */ at the end.
- Commands like DROP and DELETE should be used with caution as they could result in permanent data loss without proper use of transactions or backups.


