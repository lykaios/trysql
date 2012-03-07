class Sqlcons < ActiveRecord::Base

  def checkquery
	#create a regexp object based on string we recieve from controller
	reg = Regexp.new(regtext.to_s)
	return qtext =~ reg 
  end
end
