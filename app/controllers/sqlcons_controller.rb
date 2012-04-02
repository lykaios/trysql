class SqlconsController < ApplicationController
  #qvarname means it has to do with query

  # GET /sqlcons
  # GET /sqlcons.json
  def index
  	#define session variables to load correct tutorial views
  	session[:tutch]   = 1
    session[:tutsec]  = 1  
  	session[:maxsec]  = 7	
  	session[:maxch]   = 2	
  	session[:uid]     = 1 
  	#Insert data into database
  	respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @sqlcons }
      end
    end

  #Returns users query into controller from view
  #@qstring = the query passed through params
  def fetchquery
  	#Save initial query so user doesn't see uid regulation	
  	@qstring_init = params[:q].downcase 
  	@qstring      = @qstring_init
  	#Pull back regexp for the specific lesson
  	sectionregex = Sqlcons.select(:regtext).where(:ch => session[:tutch], :sec => session[:tutsec]).first.regtext
  	@qmodel      = Sqlcons.new(:id => 1, :qtext=> @qstring, :regtext => sectionregex)


  	#Validate whether the query is valid
  	if @qmodel.checkquery
  	  #Call method to execute query
  	  execquery	
  	else
  	  @qstatus = 2
  	end

  	#call method determining which errors to display, if any
  	pickdisplay  
  	render :show 
  end

  # TODO: Add 'private' statement here to protect any method below if they don't have a corresponding view

  #Executes a given query against the chosen database
  def execquery
  	@qstatus = 0

  	#Fetch query results, rescue from any mysql exceptions
  	begin
  	  @qstring = append_query(@qstring) 
      # OPTIMIZE: Don't need to instantiate
      # query = Dbq.new(:qtext=> @qstring)
  	  @qresults = Dbq.execquery(@qstring)
  	rescue Exception => e
  	  #use replace function to clean up error
  	  msg = e.message.gsub /'/, ''
  	  msg = msg.gsub /Mysql2::Error:(.*?)(:)(.*)/, '\1'
  	  errquery = "select '"+ msg + "' as errormsg"
  	  @qresults = ActiveRecord::Base.connection.execute(errquery)
  	  #sql syntax exception key
  	  @qstatus = 1
  	end
	
  end

  #Used to control which rows a user can see. (Associated with their user id)
  def append_query(p_qstring)
	  uid      = current_user.id.to_s
	  tabname  = p_qstring[/(from)( )*([_a-z]+)( )*([_a-z]*)/, 3]
	  tabalias = p_qstring[/(from)( )*([_a-z]+)( )*([_a-z]*)/, 5]
<<<<<<< HEAD
	  if (tabalias == nil)  || (tabalias =~ /(where|join|group|order)/) 
		where_clause = ' where '+ tabname + '.uid = ' + uid
	  else	
		where_clause = ' where '+ tabalias + '.uid = ' + uid
=======

    # FIXME: I was getting errors on this, so I rewrote the logic and it seemed to work
    # but you know the code better than I so maybe there was a reason for it
	  if not tabalias.nil? and not tabalias.include?('join')
  		where_clause = ' where '+ tabname + '.uid = ' + uid
	  else	
  		where_clause = ' where '+ tabname + '.uid = ' + uid
>>>>>>> 2ea66ff617596c5789a6eab5ec04a72a8d2ae7ee
	  end
	  
	  #We have to modify where we place 'where_clause' based on the incoming 
	  # SQL statment. Otherwise we create a syntax error
	  if p_qstring =~ /(where)/
  		ret_string = p_qstring.gsub /(where)/, where_clause + ' and '
	  elsif p_qstring =~ /(group)/
  		ret_string = p_qstring.gsub /(group)/, where_clause + ' group '
	  elsif p_qstring =~ /(order)/
  		ret_string = p_qstring.gsub /(order)/, where_clause + ' order '
	  else
  		ret_string = p_qstring + where_clause 
	  end
	  return ret_string
  end

  # TODO: Move this method to right below 'fetchquery' 
  def nextlesson
  	#Checks to see if user desired increment
  	  #Would like to change the value of those params.
  	if session[:tutsec] < session[:maxsec]
  	  session[:tutsec] += 1
  	elsif params[:nextch] == "nextch" && session[:tutch] < session[:maxch]
  	  session[:tutch] += 1
  	  session[:tutsec] = 1
  	end
  	@qstatus = 3 
  	@qresults = nil
  	pickdisplay
  	render :show
  end
  
  #Based on current state of @qstatus, determines whether to 
  #display next stage in tutorial, or a specific error page
  def pickdisplay
  	#successful query or incrementing section
  	tutname = "tut" + session[:tutch].to_s + "-" + session[:tutsec].to_s + ".html"
  	#mysqlerror
  	if @qstatus == 1
  	  errname = "sqlerror.html"	
  	#not good query for lesson
  	else
  	  errname = "qerror.html"
  	end
  	#bool to determine views display
  	@waserror = @qstatus != 0 and @qstatus != 3 
  	path = Rails.root + "app/views/sqlcons/tutorials/"
  	@lesson_name = path + tutname 
  	@error_name = path + errname
  end


end
