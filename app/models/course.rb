class Course < ActiveRecord::Base
  validates :title, :presence => true
  validates :id,  :uniqueness => true
  validates :cnum, :presence => true
end
