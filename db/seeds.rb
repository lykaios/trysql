# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
Sqlcons.create(ch: 2,sec:  2,regtext: '(select)(.*?)(course_fcts)(.*?)(left join)(.*?)');

#Test Only
#Create the first user as having completed the first lesson
#Userlesson.create(completed_ch: 2, uid: 1 );

#Chapter description for each chapter.
Chapters.create( title:'Select' , description:'The most basic forms of querying a database');
Chapters.create( title:'Joins' , description:'How to link tables together');
Chapters.create( title:'Functions' , description:'Aggregate functions and analytics');

