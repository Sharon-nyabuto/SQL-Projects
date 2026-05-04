-- Q1.  Create a schema called nairobi_academy and make sure SQL is using it.

CREATE SCHEMA nairobi_school;
set search_path to nairobi_school;
select * from subjects;

-- Q2.  Create the students table with the correct columns and constraints.
CREATE TABLE students (
    student_id      INT          PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    gender          VARCHAR(1),
    date_of_birth   DATE,
    class           VARCHAR(10),
    city            VARCHAR(50)
);

-- Q3.  Create the subjects table with the correct columns and constraints.
CREATE TABLE subjects (
    subject_id    INT           PRIMARY KEY,
    subject_name  VARCHAR(100) NOT NULL UNIQUE,
    department    VARCHAR(50),
    teacher_name  VARCHAR(100),
    credits       INT
);


-- Q4.  Create the exam_results table with the correct columns and constraints.
CREATE TABLE exam_results (
    result_id   INT   PRIMARY KEY,
    student_id  INT   NOT NULL,
    subject_id  INT   NOT NULL,
    marks       INT   NOT NULL,
    exam_date   DATE,
    grade       VARCHAR(2)
);

-- Q5.  Use ALTER TABLE to add phone_number VARCHAR(20) to the students table.
ALTER TABLE students
ADD COLUMN phone_number VARCHAR(20);

-- Q6.  Rename the column credits to credit_hours in the subjects table.
ALTER TABLE subjects
RENAME COLUMN credits TO credit_hours;

-- Q7.  Drop the phone_number column from the students table.
ALTER TABLE students
DROP COLUMN phone_number;

-- Q8.  Insert all 10 students into the students table.
INSERT INTO students (student_id, first_name, last_name, gender, date_of_birth, class, city)
VALUES
    (1, 'Amina',  'Wanjiku', 'F', '2008-03-12', 'Form 3', 'Nairobi'),
    (2, 'Brian',  'Ochieng', 'M', '2007-07-25', 'Form 4', 'Mombasa'),
    (3, 'Cynthia','Mutua',   'F', '2008-11-05', 'Form 3', 'Kisumu'),
    (4, 'David',  'Kamau',   'M', '2007-02-18', 'Form 4', 'Nairobi'),
    (5, 'Esther', 'Akinyi',  'F', '2009-06-30', 'Form 2', 'Nakuru'),
    (6, 'Felix',  'Otieno',  'M', '2009-09-14', 'Form 2', 'Eldoret'),
    (7, 'Grace',  'Mwangi',  'F', '2008-01-22', 'Form 3', 'Nairobi'),
    (8, 'Hassan', 'Abdi',    'M', '2007-04-09', 'Form 4', 'Mombasa'),
    (9, 'Ivy',    'Chebet',  'F', '2009-12-01', 'Form 2', 'Nakuru'),
    (10,'James',  'Kariuki', 'M', '2008-08-17', 'Form 3', 'Nairobi');

-- Q9.  Insert all 10 subjects into the subjects table.
INSERT INTO subjects (subject_id, subject_name, department, teacher_name, credit_hours)
VALUES
    (1,  'Mathematics',     'Sciences',   'Mr. Njoroge',  4),
    (2,  'English',         'Languages',  'Ms. Adhiambo', 3),
    (3,  'Biology',         'Sciences',   'Ms. Otieno',   4),
    (4,  'History',         'Humanities', 'Mr. Waweru',   3),
    (5,  'Kiswahili',       'Languages',  'Ms. Nduta',    3),
    (6,  'Physics',         'Sciences',   'Mr. Kamande',  4),
    (7,  'Geography',       'Humanities', 'Ms. Chebet',   3),
    (8,  'Chemistry',       'Sciences',   'Ms. Muthoni',  4),
    (9,  'Computer Studies','Sciences',   'Mr. Oduya',    3),
    (10, 'Business Studies','Humanities', 'Ms. Wangari',  3);


-- Q10.  Insert all 10 exam results into the exam_results table.
INSERT INTO exam_results (result_id, student_id, subject_id, marks, exam_date, grade)
VALUES
    (1,  1, 1, 78, '2024-03-15', 'B'),
    (2,  1, 2, 85, '2024-03-16', 'A'),
    (3,  2, 1, 92, '2024-03-15', 'A'),
    (4,  2, 3, 55, '2024-03-17', 'C'),
    (5,  3, 2, 49, '2024-03-16', 'D'),
    (6,  3, 4, 71, '2024-03-18', 'B'),
    (7,  4, 1, 88, '2024-03-15', 'A'),
    (8,  4, 6, 63, '2024-03-19', 'C'),
    (9,  5, 5, 39, '2024-03-20', 'F'),
    (10, 6, 9, 95, '2024-03-21', 'A');

-- Q11.  Run a SELECT query to confirm all 10 rows exist in each table.
SELECT * FROM students;

SELECT * FROM subjects;

SELECT * FROM exam_results;






































