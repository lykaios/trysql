class Sqlcons < ActiveRecord::Base
#This model contains the regexp for each individual lesson we go through.

  def checkquery
	#create a regexp object based on string we recieve from controller
	#true makes for case insensitive matching
	reg = Regexp.new(regtext.to_s,true)
	#regexp to make validate against common sqlinjection
	reg2 = Regexp.new('(alter|drop|create|index|truncate|show|sqlcons|dbq|schema_migrations|;|union)',true)
	
	#Check if regexp was valid for lesson, and not a sqlinject attempt	
	return (qtext =~ reg && !(qtext =~ reg2)) 
  end


end
