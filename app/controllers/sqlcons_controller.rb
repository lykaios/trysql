class SqlconsController < ApplicationController
  # GET /sqlcons
  # GET /sqlcons.json
  def index
	#define session variables to load correct tutorial views
	session[:tutch] = 1
    session[:tutsec] = 0 
	
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sqlcons }
    end
  end

  #Gets query from input
  def fetchquery
    
    @qstring = params[:q]
    #render :text => qstring
	@qresults = ActiveRecord::Base.connection.execute(@qstring)
    session[:tutsec] += 1 
	
	render :show
  end

end
