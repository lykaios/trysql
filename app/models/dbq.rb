class Dbq < ActiveRecord::Base
  establish_connection(ActiveRecord::Base.configurations['dev_data'])  

#This model is used to execute a query to an alternate database
#By the time the query arrives here, it has been properly sanitized. 
#The justification for this is to hide rails application DB from users,
# by pointing them to a "sandbox" type database, just holding tables
# for them to query against. 

  def execquery
	return connection.execute(qtext)
  end
 
#Method is called when a new user is created.
#Inserts all necessary default values into sandbox database to allow 
#for querying

  def db_insert(user_id)
	#Have to specify connection in order to create in alternate database
	connection.execute "INSERT INTO students (id, fname, lname, uid) values (1, 'Nate', 'Allen', #{user_id})"
	connection.execute "INSERT INTO students (id, fname, lname, uid) values (2, 'Ian', 'Eckert', #{user_id})"
	connection.execute "INSERT INTO students (id, fname, lname, uid) values (3, 'Ross', 'Bailey', #{user_id})"
	connection.execute "INSERT INTO students (id, fname, lname, uid) values (4, 'Andre', 'Harris', #{user_id})"
	connection.execute "INSERT INTO students (id, fname, lname, uid) values (5, 'Steve', 'Bealer', #{user_id})"
	connection.execute "INSERT INTO students (id, fname, lname, uid) values (6, 'Scott', 'Jungling', #{user_id})"
	connection.execute "INSERT INTO students (id, fname, lname, uid) values (7, 'Kyle', 'Miller', #{user_id})"
  
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

	#Insert course_fcts


  end

end
