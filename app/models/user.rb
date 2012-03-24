class User < ActiveRecord::Base
  #Callback to insert into alternate database
  after_create :do_inserts

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def do_inserts
	#Inserts into alternate database
	query = Dbq.new(:qtext=> "stuff")
	query.db_insert(id)
  end

  #Define some sort of reset database controller. 
end
