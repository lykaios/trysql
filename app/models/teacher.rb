class Teacher < ActiveRecord::Base
  validates :name, :presence => true
  validates :id,  :uniqueness => true
end
