class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end

  def jump_to_lesson
	#Initialize session variables before we direct to that chapter
  	session[:maxsec]  = 7	
  	session[:maxch]   = 2	
  	session[:tutch]   = 2
    session[:tutsec]  = 0 
	#Now go to our sqlcons controller
	redirect_to sqlcons_nextlesson_path
  end
end
