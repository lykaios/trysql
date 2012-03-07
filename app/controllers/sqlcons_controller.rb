class SqlconsController < ApplicationController
  # GET /sqlcons
  # GET /sqlcons.json
  def index
	#define session variables to load correct tutorial views
	session[:tutch] = 1
    session[:tutsec] = 1  
	session[:maxsec] = 7	
	session[:maxch] = 2	
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sqlcons }
    end
  end

  #Gets query from input
  def fetchquery
    @qstring = params[:q]
	@qstring = @qstring.downcase
	#Pull back regexp for the specific lesson
	secreg = Sqlcons.where(:ch => session[:tutch], :sec => session[:tutsec]).pluck(:regtext)
	@qmodel = Sqlcons.new(:id => 1, :qtext=> @qstring, :regtext => secreg[0])


	#Validate whether the query is valid
	if @qmodel.checkquery
	  session[:qcheck] = 'good'
	  #Fetch query results
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
	else
	  #Error msg as query, clean this up
	  errquery = "select 'There was an error in your query, please try again' as errormsg from dual"
	  @qresults = ActiveRecord::Base.connection.execute(errquery)
	  session[:qcheck] = 'bad'
	end
	render :show
  end
  

end
