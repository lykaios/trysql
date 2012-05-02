class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  #Check if user isn't signed in. 
  def validate_user
	if user_signed_in?
	else
	  redirect_to root_path
	end
  end
end
