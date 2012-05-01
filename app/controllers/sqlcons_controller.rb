class SqlconsController < ApplicationController
  #qvarname means it has to do with query

  # GET /sqlcons
  # GET /sqlcons.json
  def index
  	session[:maxsec]  = Chapters.select(:maxlesson).where("id = 1").first.maxlesson	
  	session[:maxch]   = Chapters.maximum(:id)
  	session[:tutch]   = 1
    session[:tutsec]  = 1  
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
	#Use strip to trim out the whitespace
  	@qstring      = @qstring_init.strip
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
  
  #Increments session parameters if user wants to advance lesson.
  def nextlesson
	cur_sec_max = Chapters.select(:maxlesson).where(:id => session[:tutch]).first.maxlesson
	app_ch_max = Chapters.maximum("id")
	#If we haven't hit the last lesson in chapter, or last chapter of tutorial
	# increment lesson. Otherwise on to the next chapter
	if (session[:tutsec] < cur_sec_max) 
  	  session[:tutsec] += 1
  	elsif (session[:tutch] == app_ch_max)
	  nil
	else 
	  #Check if this chapter is higher than the users last completed
	  cur_max = Userlesson.select(:completed_ch).where(:uid => current_user.id).first.completed_ch 
	  Userlesson.update(current_user.id, :completed_ch => session[:tutch]) if session[:tutch] > cur_max
  	  session[:tutch] += 1
  	  session[:tutsec] = 1
	end
	@qstatus = 3 
  	@qresults = nil
  	pickdisplay
  	render :show
  end

  #Define methods private to controller (all listed below)
  private

  #Executes a given query against the chosen database
  def execquery
  	@qstatus = 0

  	#Fetch query results, rescue from any mysql exceptions
  	begin
  	  @qstring = append_query(@qstring) 
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
	 
	  #If it is a join statement, need to include uid in "on" clause, 
	  # else the results are not what user intended. 
	  #We have to modify where we place 'where_clause' based on the incoming 
	  # SQL statment. Otherwise we create a syntax error
	  if p_qstring =~ /(insert)/
		ret_string = p_qstring.gsub /\)/, ', ' + uid + ') \2'
	  else
		tabname  = p_qstring[/(from)( )+([_a-z]+)( )*([_a-z]*)/, 3]
		tabalias = p_qstring[/(from)( )+([_a-z]+)( )+([_a-z]*)/, 5]
		if p_qstring =~ /(update)/
		  tabname  = p_qstring[/(update)( )+([_a-z]+)( )*([_a-z]*)/, 3]
		  tabalias = p_qstring[/(update)( )+([_a-z]+)( )+([_a-z]*)/, 5]
		end
		if ( (tabalias == nil) || (tabalias =~ /(where|join|group|order)/)  )
		  table_clause = tabname + '.uid = ' + uid
		else	
		  table_clause = tabalias + '.uid = ' + uid
		end
		where_clause = ' where ' + table_clause
  
		if p_qstring =~ /(right)(.*?)(join)/
		  ret_string = p_qstring.gsub /(join)( )*([_a-z]+)( )+([_a-z]+)(.*?)(on)/, '\1 \2 \3 \4 \5 \6 \7 \5.uid = ' + uid + ' and '
		elsif p_qstring =~ /(join)/
		  ret_string = p_qstring.gsub /(on)(.*?)([_a-z]*)\.([_a-z]*)(.*?)([_a-z]+)\.([_a-z]+)/, '\1 \2\3.uid = \6.uid and \3.uid = '+uid+' and \3.\4 = \6.\7'
		elsif p_qstring =~ /(where)/
		  ret_string = p_qstring.gsub /(where)/, where_clause + ' and '
		elsif p_qstring =~ /(group)/
		  ret_string = p_qstring.gsub /(group)/, where_clause + ' group '
		elsif p_qstring =~ /(order)/
		  ret_string = p_qstring.gsub /(order)/, where_clause + ' order '
		else
		  ret_string = p_qstring + where_clause 
		end
	  end
	  return ret_string
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
  	@waserror = (@qstatus != 0 and @qstatus != 3) 
  	path = Rails.root + "app/views/sqlcons/tutorials/"
  	@lesson_name = path + tutname 
  	@error_name = path + errname
	@help_name = path + "help.html"
  end


end
