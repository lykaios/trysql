class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  #Put logic to fetch max lesson
  #Pass a variable to view to determine how much of lesson table to display
  maxlesson = Userlesson.select(:completed_ch).where(:uid => current_user.id).first.completed_ch
  if maxlesson == 0  
	@chapters = nil
  else
	@chapters = Chapters.select("id, title,description").where("id <= #{maxlesson}")
  end
  #query = "select title, description from chapters where id <= #{maxlesson}"
  #@chapters = ActiveRecord::Base.connection.execute(query)
  end

  def jump_to_lesson
	#Initialize session variables before we direct to that chapter
  	session[:maxsec]  = 7	
  	session[:maxch]   = 2	
  	session[:tutch]   = params[:id] 
	session[:tutsec]  = 0 
	#Now go to our sqlcons controller
	redirect_to sqlcons_nextlesson_path
  end
end
