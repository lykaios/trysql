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
    
	#Checks to see if user desired increment
	  #Would like to change the value of those params.
	if params[:nextsec] == "nextsec" &&  session[:tutsec] < session[:maxsec]
	  session[:tutsec] += 1
	elsif params[:nextch] == "nextch" && session[:tutch] < session[:maxch]
	  session[:tutch] += 1
	  session[:tutsec] = 1
	else
	end
	render :show
  end
  

end
