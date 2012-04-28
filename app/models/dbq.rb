class Dbq < ActiveRecord::Base
  establish_connection(ActiveRecord::Base.configurations['dev_data'])  

  #This model is used to execute a query to an alternate database
  #By the time the query arrives here, it has been properly sanitized. 
  #The justification for this is to hide rails application DB from users,
  # by pointing them to a "sandbox" type database, just holding tables
  # for them to query against. 

  #self. allows model to call method without instantiating class. 
  def self.execquery(query)
	  return connection.execute(query)
  end
 
  #Method is called when a new user is created.
  #Inserts all necessary default values into sandbox database to allow 
  #for querying
  def self.db_insert(user_id)
  	#Have to specify connection in order to create in alternate database
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (1, 'Nate', 'Allen', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (2, 'Ian', 'Eckert', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (3, 'Ross', 'Bailey', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (4, 'Andre', 'Harris', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (5, 'Steve', 'Bealer', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (6, 'Scott', 'Jungling', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (7, 'Kyle', 'Miller', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (8, 'Kyle', 'Marx', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (9, 'Zack', 'Larx', #{user_id})"
  	connection.execute "INSERT INTO students (id, fname, lname, uid) values (10, 'John', 'Carx', #{user_id})"
  
  	#Insert courses
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('1','CSCI','224','PHP Grammar','Learn the basics.',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('2','CSCI','241','Assembly Language','FP representation and moar.',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('3','NSCI','386','Microbiology','Celluar reactions and such',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('4','CSCI','143','Algorithms','Basic C++ coding',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('5','CSCI','212','Algorithms-II','Pointers and the stack',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('6','SPAN','356','Advanced Grammar','Preterito, imperfecto, subjuntivo',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('7','CSCI','288','Intro to Databases','Write SQL, hell yeah!',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('8','SPAN','126','Intro to Spanish','Basics of the language.',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('9','NSCI','218','Enviromentalism','The world and your place in it',#{user_id})"
  	 connection.execute "INSERT INTO courses (id,dept,cnum,title,cdesc,uid) VALUES ('10','NSCI','144','Birded Communities','I made this one up',#{user_id})"
	
  	#Insert teachers
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('1','Cameran','Brady',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('2','Hyatt','Melton',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('3','Ezekiel','Potts',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('4','Emery','Levy',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('5','Genevieve','Payne',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('6','Dominique','Waller',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('7','Reese','Cortez',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('8','Dennis','Long',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('9','Heidi','Coffey',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('10','Carlos','Rutledge',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('11','Guy','Fox',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('12','Jeff','McLeel',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('13','Jack','Lynch',#{user_id})"
  	connection.execute "INSERT INTO teachers (id,fname,lname,uid) VALUES ('14','Carlos','Ruteger',#{user_id})"
	
  	#Insert course_fcts
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('1','2012','S','2','6','5',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('2','2011','S','6','9','4',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('3','2010','S','1','2','5',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('4','2012','F','9','7','3',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('5','2010','S','2','6','3',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('6','2010','S','4','8','4',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('7','2010','S','7','5','5',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('8','2011','S','8','5','6',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('9','2010','S','6','4','3',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('10','2011','F','7','3','6',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('11','2010','F','9','4','2',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('12','2011','F','2','10','4',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('13','2011','S','5','9','2',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('14','2011','S','10','8','1',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('15','2010','F','7','4','4',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('16','2012','F','10','1','6',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('17','2011','F','2','5','7',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('18','2012','F','5','8','7',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('19','2010','F','5','10','6',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('20','2012','S','9','10','6',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('21','2011','F','7','5','1',#{user_id})"
  	connection.execute "INSERT INTO course_fcts (id,year,semester,teacher_id,course_id,student_id,uid) VALUES ('22','2010','F','5','8','7',#{user_id})"
  end
  
  def self.db_reset(user_id)
  	#Have to specify connection in order to create in alternate database
  	connection.execute "delete from students where uid = #{user_id}"
  	connection.execute "delete from teachers where uid = #{user_id}"
  	connection.execute "delete from courses where uid = #{user_id}"
  	connection.execute "delete from course_fcts where uid = #{user_id}"
	db_insert(user_id)	 
  end
end
