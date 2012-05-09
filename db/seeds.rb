# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#Sqlcons = the table holding regexp for a lesson
Sqlcons.create(ch: 1,sec:  1,regtext: '(select)(.*?)');
Sqlcons.create(ch: 1, sec: 2, regtext: '(select)(.*?)(students)(.*?)(where)');
Sqlcons.create(ch: 1, sec: 3, regtext: '(select)(.*?)(where)(.*?)(cnum)(.*?)');
Sqlcons.create(ch: 1, sec: 4, regtext: '(select)(.*?)(students)(.*?)(where)(.*?)(like)');
Sqlcons.create(ch: 1, sec: 5, regtext: '(select)(.*?)(teachers)(.*?)(where)(.*?)(like)');
Sqlcons.create(ch: 1, sec: 6, regtext: '(select)(.*?)(courses)(.*?)(order)');
Sqlcons.create(ch: 1, sec: 7, regtext: '(select)(.*?)(courses)(.*?)(order)(.*?)([0-5])+');

#Chapter 2
Sqlcons.create(ch: 2,sec:  1,regtext: '(select)(.*?)(course_fcts)(.*?)(join)(.*?)');
Sqlcons.create(ch: 2,sec:  2,regtext: '(select)(.*?)(course_fcts)(.*?)(join)(.*?)');
Sqlcons.create(ch: 2,sec:  3,regtext: '(select)(.*?)(students)(.*?)(left join)(.*?)');
Sqlcons.create(ch: 2,sec:  4,regtext: '(select)(.*?)(teachers)(.*?)(left join)(.*?)');
Sqlcons.create(ch: 2,sec:  5,regtext: '(select)(.*?)(course_fcts)(.*?)(right join)(.*?)');

#Chapter 3
Sqlcons.create(ch: 3,sec: 1,regtext: '(insert|select)(.*?)(students)');
Sqlcons.create(ch: 3,sec: 2,regtext: '(insert|select)(.*?)(teachers)');
Sqlcons.create(ch: 3,sec: 3,regtext: '(delete|select)(.*?)(courses)');
Sqlcons.create(ch: 3,sec: 4,regtext: '(update)(.*?)(courses)( )+(set)|(select)(.*?)(courses)');

#Chapter 4
Sqlcons.create(ch: 4,sec: 1,regtext: '(select)(.*?)(count)');
Sqlcons.create(ch: 4,sec: 2,regtext: '(select)(.*?)(group by)');
Sqlcons.create(ch: 4,sec: 3,regtext: '(select)(.*?)(having)');
Sqlcons.create(ch: 4,sec: 4,regtext: '(select)(.*?)(max|min)');

#Chapter description for each chapter.
Chapters.create( title:'Select' , description:'The most basic forms of querying a database');
Chapters.create( title:'Join' , description:'How to link tables together');
Chapters.create( title:'Insert/Delete' , description:'Adding/removing rows in a table');
Chapters.create( title:'Functions' , description:'Aggregate functions and analytics');

