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
  end

  def jump_to_lesson
    chapter = params[:id]
    #Initialize session variables before we direct to that chapter
    session[:maxsec]  = Sqlcons.maximum(:sec, :conditions => "ch = #{chapter}")	
    session[:maxch]   = Chapters.maximum(:id)
    session[:tutch]   = chapter.to_i 
    session[:tutsec]  = 0 
    #Now go to our sqlcons controller
    redirect_to sqlcons_nextlesson_path
  end
 
  #For use if users mess up their data, and want to reset it
  def reset_data
    Dbq.db_reset(current_user.id)
    redirect_to root_path	
  end
end
