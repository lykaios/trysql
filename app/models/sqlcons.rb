class Sqlcons < ActiveRecord::Base
  validates_format_of :qtext, :with => /select.*/mi 
end
