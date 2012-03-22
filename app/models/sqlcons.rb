class Sqlcons < ActiveRecord::Base
#establish_connection("sandbox")
#this will make it so everything done in this model only interacts with this db. 
  def checkquery
	#create a regexp object based on string we recieve from controller
	reg = Regexp.new(regtext.to_s)
	#regexp to make validate against common sqlinjection
	reg2 = Regexp.new('(drop|create|index|truncate|show|sqlcons|schema_migrations|;)')
	
	#Check if regexp was valid for lesson, and not a sqlinject attempt	
	return (qtext =~ reg && !(qtext =~ reg2)) 
  end


end
