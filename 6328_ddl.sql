CREATE DATABASE registrationsystem;
CREATE TABLE department(
   dept_id INT PRIMARY KEY,
 	dept_name varChar(50) not null 
);
CREATE TABLE student(
	student_id INT PRIMARY KEY ,
    student_name varchar(50) not null,
    major varchar(50) not null ,
    `level` varchar(10) NOT null,
    age INT not null
);
CREATE TABLE professor(
         prof_id INT PRIMARY key,
         prof_name varchar(50) not null,
	dept_id INT not null,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id) on DELETE CASCADE ON UPDATE CASCADE
);
 CREATE TABLE course (
 course_code varchar(30) PRIMARY key,
  name varChar(30) not null
 );
 CREATE TABLE semester_course(
  course_code varchar(30) ,
  quarter varchar(30), 
  `year` year,
   prof_id INT not null,  
   PRIMARY key(quarter,`year`,course_code )  ,
   FOREIGN key(course_code) REFERENCES course(course_code)  on DELETE CASCADE on UPDATE CASCADE,
     FOREIGN key(prof_id) REFERENCES professor(prof_id)  on DELETE CASCADE on UPDATE CASCADE
 );
 CREATE TABLE enrolled(
 student_id INT,
     course_code varchar(30),
      quarter varchar(30),
     `year` year,
     enrolled_at date not null,
     PRIMARY key(student_id,course_code,quarter,`year`),
    FOREIGN key(student_id) REFERENCES student(student_id)  on DELETE CASCADE on UPDATE CASCADE,
     FOREIGN key(course_code,quarter,`year`) REFERENCES semester_course(course_code,quarter,`year`)  on DELETE CASCADE on UPDATE CASCADE);