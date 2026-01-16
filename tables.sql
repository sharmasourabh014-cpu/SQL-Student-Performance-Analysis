CREATE DATABASE student_analysis;
USE student_analysis;
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    course VARCHAR(20),
    city VARCHAR(30)
);
CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject VARCHAR(30),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
CREATE TABLE attendance (
    att_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    total_classes INT,
    attended_classes INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
INSERT INTO students (name, course, city) VALUES
('Rahul Sharma','BCA','Mathura'),
('Ankit Verma','BCA','Agra'),
('Neha Singh','MCA','Delhi'),
('Pooja Gupta','BCA','Noida'),
('Aman Kumar','MCA','Lucknow'),
('Ritika Jain','BCA','Jaipur');
INSERT INTO attendance (student_id, total_classes, attended_classes) VALUES
(1,120,98),
(2,120,70),
(3,120,110),
(4,120,85),
(5,120,60),
(6,120,105);
INSERT INTO marks (student_id, subject, marks) VALUES
(1,'Python',78),(1,'DBMS',82),(1,'OS',75),(1,'CN',80),
(2,'Python',55),(2,'DBMS',60),(2,'OS',58),(2,'CN',62),
(3,'Python',88),(3,'DBMS',90),(3,'OS',85),(3,'CN',87),
(4,'Python',70),(4,'DBMS',72),(4,'OS',68),(4,'CN',74),
(5,'Python',40),(5,'DBMS',45),(5,'OS',42),(5,'CN',38),
(6,'Python',92),(6,'DBMS',89),(6,'OS',94),(6,'CN',90);