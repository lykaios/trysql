class Sqlcons < ActiveRecord::Base
  validates_format_of :qtext, :with => /select.*/mi

  def checkq
	#create a regexp object based on string we recieve from controller
	reg = Regexp.new(regtext.to_s)
	return qtext =~ reg 
  end
end
