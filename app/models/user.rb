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
	#Insert into our chapter tracker, showing how far they have advanced in lessons
  	#Purely for DEV purposes, "root" user has completed all chapters
	if(id == 1)
	  connection.execute "INSERT INTO userlessons (completed_ch, uid) values (4, #{id})"
	else
	  connection.execute "INSERT INTO userlessons (completed_ch, uid) values (0, #{id})"
	end
	#Inserts into alternate database
  	Dbq.db_insert(id)
  end

end
