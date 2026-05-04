CREATE SCHEMA city_hospital;

Set search_path to  city_hospital;

CREATE TABLE departments (
    dept_id       INT          PRIMARY KEY,
    dept_name     VARCHAR(100) NOT NULL,
    location      VARCHAR(50),
    head_of_dept  VARCHAR(100)
);

CREATE TABLE doctors (
    doctor_id     INT          PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    specialisation VARCHAR(100),
    dept_id       INT,
    years_exp     INT,
    supervisor_id INT
);


CREATE TABLE patients (
    patient_id    INT          PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    age           INT,
    gender        VARCHAR(1),
    city          VARCHAR(50),
    blood_type    VARCHAR(5)
);

CREATE TABLE appointments (
    appointment_id  INT  PRIMARY KEY,
    patient_id      INT  NOT NULL,
    doctor_id       INT  NOT NULL,
    appt_date       DATE,
    diagnosis       VARCHAR(200),
    fee             DECIMAL(8,2)
);

CREATE TABLE prescriptions (
    prescription_id  INT          PRIMARY KEY,
    appointment_id   INT          NOT NULL,
    medicine_name    VARCHAR(100),
    dosage           VARCHAR(50),
    days             INT
);

INSERT INTO departments (dept_id, dept_name, location, head_of_dept) VALUES
    (1,  'Cardiology',        'Block A', 'Dr. Omondi'),
    (2,  'Paediatrics',       'Block B', 'Dr. Wambua'),
    (3,  'Orthopaedics',      'Block C', 'Dr. Mutua'),
    (4,  'Neurology',         'Block A', 'Dr. Achieng'),
    (5,  'General Surgery',   'Block D', 'Dr. Kamau'),
    (6,  'Dermatology',       'Block E', 'Dr. Njoroge'),
    (7,  'Oncology',          'Block F', 'Dr. Chebet'),
    (8,  'Ophthalmology',     'Block B', 'Dr. Otieno'),
    (9,  'Psychiatry',        'Block G', 'Dr. Kariuki'),
    (10, 'Emergency Medicine','Block H', 'Dr. Abdi');

INSERT INTO doctors (doctor_id, full_name, specialisation, dept_id, years_exp, supervisor_id) VALUES
    (1,  'Dr. Amina Omondi',  'Cardiologist',      1, 12, NULL),
    (2,  'Dr. Brian Wambua',  'Paediatrician',     2,  8, 1),
    (3,  'Dr. Clara Mutua',   'Orthopaedic Surg.', 3, 15, 1),
    (4,  'Dr. David Achieng', 'Neurologist',       4,  6, 1),
    (5,  'Dr. Esther Kamau',  'General Surgeon',   5, 10, 3),
    (6,  'Dr. Felix Njoroge', 'Dermatologist',     6,  4, 3),
    (7,  'Dr. Grace Chebet',  'Oncologist',        7,  9, 1),
    (8,  'Dr. Hassan Otieno', 'Ophthalmologist',   8,  7, 2),
    (9,  'Dr. Ivy Kariuki',   'Psychiatrist',      9,  5, 2),
    (10, 'Dr. James Abdi',    'Emergency Med.',    10, 11, NULL);


INSERT INTO patients (patient_id, full_name, age, gender, city, blood_type) VALUES
    (1,  'Mwangi Njoroge',   45, 'M', 'Nairobi',  'A+'),
    (2,  'Fatuma Said',       32, 'F', 'Mombasa',  'B+'),
    (3,  'Peter Kimani',      58, 'M', 'Kisumu',   'O+'),
    (4,  'Aisha Waweru',      27, 'F', 'Nairobi',  'AB+'),
    (5,  'John Odhiambo',     63, 'M', 'Eldoret',  'A-'),
    (6,  'Mary Chebet',       41, 'F', 'Nakuru',   'O-'),
    (7,  'Ali Hassan',        35, 'M', 'Mombasa',  'B-'),
    (8,  'Grace Muthoni',     29, 'F', 'Nairobi',  'A+'),
    (9,  'Samuel Otieno',     52, 'M', 'Kisumu',   'AB-'),
    (10, 'Winnie Adhiambo',   38, 'F', 'Nairobi',  'O+');


INSERT INTO appointments (appointment_id, patient_id, doctor_id, appt_date, diagnosis, fee) VALUES
    (1,  1,  1, '2024-04-01', 'Hypertension',       2500.00),
    (2,  2,  2, '2024-04-02', 'Child Fever',        1500.00),
    (3,  3,  3, '2024-04-03', 'Knee Fracture',      5000.00),
    (4,  4,  4, '2024-04-04', 'Migraine',           3000.00),
    (5,  5,  5, '2024-04-05', 'Appendicitis',       8000.00),
    (6,  6,  1, '2024-04-06', 'Arrhythmia',         2500.00),
    (7,  7,  7, '2024-04-07', 'Lung Cancer Screen', 6000.00),
    (8,  8,  6, '2024-04-08', 'Eczema',             1800.00),
    (9,  1,  4, '2024-04-09', 'Headache Follow-up', 1500.00),
    (10, 3,  5, '2024-04-10', 'Post-op Review',     2000.00);


INSERT INTO prescriptions (prescription_id, appointment_id, medicine_name, dosage, days) VALUES
    (1,  1,  'Amlodipine',      '5mg once daily',    30),
    (2,  2,  'Paracetamol',     '250mg three daily',  5),
    (3,  3,  'Ibuprofen',       '400mg twice daily', 14),
    (4,  4,  'Sumatriptan',     '50mg when needed',   7),
    (5,  5,  'Metronidazole',   '500mg three daily',  7),
    (6,  6,  'Bisoprolol',      '2.5mg once daily',  30),
    (7,  7,  'Carboplatin',     '300mg IV weekly',   12),
    (8,  8,  'Hydrocortisone',  '1% cream twice',    14),
    (9,  9,  'Ibuprofen',       '400mg three daily',  5),
    (10, 10, 'Amoxicillin',     '500mg three daily',  7);



















