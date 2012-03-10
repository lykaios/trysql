class SqlconsController < ApplicationController
	  #rescue_from ActiveRecord::RecordNotFound, :with => :bad_record
	  rescue_from Mysql2::Error, :with => :bad_record
  
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
    # qvarname means it has to do with the incoming query. 
	
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
	  @qvalid = true
	  #Fetch query results, rescue from any mysql exceptions
	  begin
		@qresults = ActiveRecord::Base.connection.execute(@qstring)
	  rescue
		render :file => '/home/nate/public/trysql/app/views/sqlcons/tutorials/sqlerror.html' and return
	  end
	  
	  #rescue_from(ActiveRecord::RecordNotFound) { |e| render :file => '/views/sqlcons/tutorials/qerror.html' }
	  #Checks to see if user desired increment
		#Would like to change the value of those params.
	  if params[:nextsec] == "nextsec" &&  session[:tutsec] < session[:maxsec]
		session[:tutsec] += 1
	  elsif params[:nextch] == "nextch" && session[:tutch] < session[:maxch]
		session[:tutch] += 1
		session[:tutsec] = 1
	  end
	else
	  #Error msg as query, clean this up
	  errquery = "select 'There was an error in your query, please try again' as errormsg from dual"
	  @qresults = ActiveRecord::Base.connection.execute(errquery)
	  @qvalid = false
	end
	render :show

  end
	protected
	def bad_record 
	  render :file => '/views/sqlcons/tutorials/qerror.html'
	end

end
