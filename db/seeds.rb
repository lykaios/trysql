# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Add Courses
Course.create(dept: 'CSCI',cnum: '111', title: 'Intro to Algorithms', desc: 'Basics of programming');
Course.create(dept: 'CSCI',cnum: '221', title: 'Intermediate Algorithms', desc: 'Intermediate concepts of programming'); 
Course.create(dept: 'CSCI',cnum: '370', title: 'Intro to Databases', desc: 'Databasing concepts, sql/oracle'); 
Course.create(dept: 'CSCI',cnum: '515', title: 'Compiler Design', desc: 'Learn symbol tables, trees, awesomeness');

#Add Students
Student.create(name: 'Nate Allen');
Student.create(name: 'Scott Jungling');
Student.create(name: 'Ross Bailey');
Student.create(name: 'Andre Harris');
Student.create(name: 'Steve Bealer');
Student.create(name: 'Chris K');
Student.create(name: 'Ian Eckert');

#Add Teachers
Teacher.create(name: 'DrJ');
Teacher.create(name: 'Renner');
Teacher.create(name: 'Tyson');
Teacher.create(name: 'Dr Challinger');
Teacher.create(name: 'Dr Seung-bae-im');
#Add Course_fct relationships 
Course_fct.create(year: '2011' ,semester: 'fall', teacher_id: 2, course_id: 111,student_id: 2); 
