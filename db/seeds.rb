# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Sqlcons = the table holding regexp for a lesson
Sqlcons.create(ch: 1,sec:  1,regtext: 'select.*');
Sqlcons.create(ch: 1, sec: 2, regtext: 'select');
Sqlcons.create(ch: 1, sec: 3, regtext: 'show.*');
Sqlcons.create(ch: 1, sec: 4, regtext: 'select');
Sqlcons.create(ch: 1, sec: 5, regtext: 'select');

#Add Courses
Course.create(dept: 'CSCI',cnum: '111', title: 'Intro to Algorithms', desc: 'Basics of programming');
Course.create(dept: 'CSCI',cnum: '221', title: 'Intermediate Algorithms', desc: 'Intermediate concepts of programming'); 
Course.create(dept: 'CSCI',cnum: '370', title: 'Intro to Databases', desc: 'Databasing concepts, sql/oracle'); 
Course.create(dept: 'CSCI',cnum: '515', title: 'Compiler Design', desc: 'Learn symbol tables, trees, awesomeness');
Course.create(dept: 'NSCI', cnum:'207',	 title: 'Organic Biology', desc:'', );
Course.create(dept: 'CSCI', cnum:'240',  title: 'Operating Systems', desc:'Learn the basics of your OS');
Course.create(dept: 'NSCI', cnum:'436',  title: 'Microbiology', desc:'Bacteria and the like');
Course.create(dept: 'SPAN', cnum:'346',  title: 'Spanish Grammar', desc:'');
Course.create(dept: 'CSCI', cnum:'477',  title: 'Programming Languages', desc:'Learn the pros and cons of each language');
Course.create(dept: 'CSCI', cnum:'390',  title: 'Parallel Methods', desc:'Fork, join, what?!');
Course.create(dept: 'SPAN', cnum:'269',  title: 'Spanish-II', desc:'Preterite, imperfecto, y mas');
Course.create(dept: 'NSCI', cnum:'200',  title: 'Biology of Ecosystems', desc:'Learn about the enviroment, and you in it.');

#Add Students
Student.create(name: 'Nate Allen');
Student.create(name: 'Scott Jungling');
Student.create(name: 'Ross Bailey');
Student.create(name: 'Andre Harris');
Student.create(name: 'Steve Bealer');
Student.create(name: 'Chris K');
Student.create(name: 'Ian Eckert');
Student.create(name: 'Kyle Graves');
Student.create(name: 'Kevin Hart');
Student.create(name: 'Richard Arnett');
Student.create(name: 'Saurabh Shakla');
Student.create(name: 'Dane Eckert');

#Add Teachers
Teacher.create(name: 'DrJ');
Teacher.create(name: 'Renner');
Teacher.create(name: 'Tyson');
Teacher.create(name: 'Dr Challinger');
Teacher.create(name: 'Dr Seung-bae-im');

#Add Course_fct relationships 
Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 2, course_id: 1,student_id: 2);
Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 2, course_id: 1,student_id: 3); 
Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 2, course_id: 1,student_id: 4); 
Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 2, course_id: 1,student_id: 5); 
Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 2, course_id: 1,student_id: 6); 
Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 2, course_id: 1,student_id: 7); 
Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 2, course_id: 1,student_id: 8); 
Course_fct.create(year: '2011' ,semester: 'spring', teacher_id: 3, course_id: 2,student_id: 2); 
Course_fct.create(year: '2011' ,semester: 'spring', teacher_id: 3, course_id: 2,student_id: 3); 
#Course_fct.create(year: '2011' ,semester: 'spring', teacher_id: 3, course_id: 2,student_id: 4); 
#Course_fct.create(year: '2011' ,semester: 'fall'  teacher_id: 3, course_id: 2, student_id: 5); 
#Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 3, course_id: 3, student_id: 2); 
#Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 3, course_id: 3, student_id: 3); 
#Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 3, course_id: 3, student_id: 4); 
#Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 4, course_id: 4, student_id: 5); 
#Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 4, course_id: 5, student_id: 5); 
#Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 4, course_id: 6, student_id: 5); 
#Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 4, course_id: 6, student_id: 4); 
#Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 4, course_id: 6, student_id: 3); 




