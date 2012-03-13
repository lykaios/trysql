class SqlconsController < ApplicationController
  #qvarname means it has to do with query

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

  #Returns users query into controller from view
  #@qstring = the query passed through params
  def fetchquery
	
	@qstring = params[:q]
	@qstring = @qstring.downcase
	#If they are querying for fun, make sure we match previous lesson's regexp
	pluck_section = session[:tutsec]
	if params[:nextsec] != 'nextsec'
	  pluck_section = pluck_section - 1
	end

	#Pull back regexp for the specific lesson
	sectionregex = Sqlcons.where(:ch => session[:tutch], :sec => pluck_section).pluck(:regtext)
	@qmodel = Sqlcons.new(:id => 1, :qtext=> @qstring, :regtext => sectionregex[0])


	#Validate whether the query is valid
	if @qmodel.checkquery
	  #Call method to execute query
	  execquery	
	else
	  @qstatus = 2
	  #Error msg as query, clean this up
	  errquery = "select 'There was an error in your query, please try again' as errormsg from dual"
	  @qresults = ActiveRecord::Base.connection.execute(errquery)
	end

	#implement a new method to calculate view display
	pickdisplay  
	render :show 
  end

  #Executes a given query against the chosen database
  #Increments session variables if users desire to move on
  def execquery
	@qstatus = 0
	#Fetch query results, rescue from any mysql exceptions
	begin
	  @qresults = ActiveRecord::Base.connection.execute(@qstring)
	rescue
	  @qstatus = 1
	end
	
	#Checks to see if user desired increment
	  #Would like to change the value of those params.
	if params[:nextsec] == "nextsec" &&  session[:tutsec] < session[:maxsec]
	  session[:tutsec] += 1
	elsif params[:nextch] == "nextch" && session[:tutch] < session[:maxch]
	  session[:tutch] += 1
	  session[:tutsec] = 1
	end
  end


  #Based on current state of @qstatus, determines whether to 
  #display next stage in tutorial, or a specific error page
  def pickdisplay
	if @qstatus == 0 
	  tutname = "tut" + session[:tutch].to_s + "-" + session[:tutsec].to_s + ".html"
	elsif @qstatus == 1
	  tutname = "sqlerror.html"	
	else
	  tutname = "qerror.html"
	end

	@file_name = "/home/nate/public/trysql/app/views/sqlcons/tutorials/" + tutname 
  end

end
