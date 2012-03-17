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
end
