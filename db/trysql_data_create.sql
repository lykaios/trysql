/* Ensure we are in proper DB */
use trysql_data; 

/*Drop tables, or later DB? */
drop table if exists courses;
drop table if exists teachers;
drop table if exists students;
drop table if exists course_fcts;

/*Create tables*/
CREATE TABLE courses (id int, dept varchar(255), cnum int, title varchar(100), cdesc varchar(255), uid int, PRIMARY KEY (id, uid)); 
CREATE TABLE teachers (id int, fname varchar(40), lname varchar(40), uid int, PRIMARY KEY (id, uid));

CREATE TABLE students (id int, fname varchar(40), lname varchar(40), uid int, PRIMARY KEY (id, uid));

CREATE TABLE course_fcts (id int, year int, semester varchar(1), teacher_id int, course_id int, student_id int, uid int, PRIMARY KEY (id, uid));


