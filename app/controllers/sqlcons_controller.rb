class SqlconsController < ApplicationController
  # GET /sqlcons
  # GET /sqlcons.json
  def index
	#define session variables to load correct tutorial views
	session[:tutch] = 1
    session[:tutsec] = 1  
	session[:maxsec] = 3	
	session[:maxch] = 2	
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sqlcons }
    end
  end

  #Gets query from input
  def fetchquery
    
    @qstring = params[:q]
	@qresults = ActiveRecord::Base.connection.execute(@qstring)
    
	session[:tutsec] += 1
	if params[:nextsec].to_i == 1
	  session[:tutsec] += 1
	# if session[:tutsec] < session[:maxsec]
	#	session[:tutsec] += 1 
	#  end
	#elsif params[:nextch] == "1"
	#  if session[:tutch] < session[:maxch]
	#	session[:tutch] += 1 
	#  end
	end
	render :show
  end
  

end
