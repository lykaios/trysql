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
	connection.execute "INSERT INTO students (name,uid) values ('Nate2', #{user_id})"
  end

end
