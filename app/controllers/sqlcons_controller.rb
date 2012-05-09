class SqlconsController < ApplicationController
  #qvarname means it has to do with query
  #Make sure user is signed in before they can access application
  before_filter :validate_user

  # GET /sqlcons
  # GET /sqlcons.json
  def index
    session[:maxsec]  = Sqlcons.maximum(:sec, :conditions => "ch = 1")	
    session[:tutch]   = 1
    session[:tutsec]  = 1  
    pickdisplay
    render :index  
  end

  #Returns users query into controller from view
  #@qstring = the query passed through params
  def fetchquery
    #Save initial query so user doesn't see uid regulation	
    @qstring_init = params[:q].gsub(/(courses|students|course_fcts|teachers)/i) {|tab|tab.downcase}
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
  
  def nextlesson
    cur_sec_max = Sqlcons.maximum(:sec, :conditions => "ch = " + session[:tutch].to_s)
    app_ch_max = Chapters.maximum("id")
    user_done = false
    #If we haven't hit the last lesson in chapter, or last chapter of tutorial
    # increment lesson. Otherwise on to the next chapter
    if (session[:tutsec] < cur_sec_max) 
      session[:tutsec] += 1
    elsif (session[:tutch] == app_ch_max)
      user_done = true if (session[:tutch] == app_ch_max)
    else 
      #Check if this chapter is higher than the users last completed
      cur_max = Userlesson.select(:completed_ch).where(:uid => current_user.id).first.completed_ch 
      session[:tutch] += 1
      #update so that they can jump to next possible chapter
      Userlesson.update(current_user.id, :completed_ch => session[:tutch]) if session[:tutch] > cur_max
      session[:tutsec] = 1
    end
    if user_done
      render :file => Rails.root + "app/views/sqlcons/tutorials/congratulations.html"
    else
      @qstatus = 3 
      @qresults = nil
      pickdisplay
      render :show
    end  
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
      #use replace function to clean up error from database
      msg = e.message.gsub /'/, ''
      msg = msg.gsub /Mysql2::Error:(.*?)(:)(.*)/, '\1'
      msg = msg.gsub /(;.*)|(trysql_data\.)/, ''
      #msg = msg.gsub /trysql_data/, ''
      errquery = "select '"+ msg + "' as errormsg"
      @qresults = ActiveRecord::Base.connection.execute(errquery)
      #sql syntax exception key
      @qstatus = 1
    end
    #If there was no error on DDL statement want to display a success message back
    if (@qstatus == 0 and @qstring =~ /(insert|update|delete)/i)
      @qresults = ActiveRecord::Base.connection.execute("select 'Data manipulation success!' as DBMSG")
    end	
  end


  #Used to control which rows a user can see. (Associated with their user id)
  def append_query(p_qstring)
    uid      = current_user.id.to_s
   
    #If it is a join statement, need to include uid in "on" clause, 
    # else the results are not what user intended. 
    #We have to modify where we place 'where_clause' based on the incoming 
    # SQL statment. Otherwise we create a syntax error
    if p_qstring =~ /(insert)/i
	  ret_string = p_qstring.gsub /\)/, ', ' + uid + ') \2'
    else
	  tabname  = p_qstring[/(from)( )+([_a-z]+)( )*([_a-z]*)/, 3]
	  tabalias = p_qstring[/(from)( )+([_a-z]+)( )+([_a-z]*)/, 5]
	  if p_qstring =~ /(update)/i
	    tabname  = p_qstring[/(update)( )+([_a-z]+)( )*([_a-z]*)/, 3]
	    tabalias = p_qstring[/(update)( )+([_a-z]+)( )+([_a-z]*)/, 5]
	  end
	  if ( (tabalias == nil) || (tabalias =~ /(where|join|group|order|set)/)  )
	    table_clause = tabname + '.uid = ' + uid
	  else	
	    table_clause = tabalias + '.uid = ' + uid
	  end
	  where_clause = ' where ' + table_clause

	  if p_qstring =~ /(right)(.*?)(join)/i
	    ret_string = p_qstring.gsub /(join)( )*([_a-z]+)( )+([_a-z]+)(.*?)(on)/i, '\1 \2 \3 \4 \5 \6 \7 \5.uid = ' + uid + ' and '
	  elsif p_qstring =~ /(join)/i
	    ret_string = p_qstring.gsub /(on)(.*?)([_a-z]*)\.([_a-z]*)(.*?)([_a-z]+)\.([_a-z]+)/i, '\1 \2\3.uid = \6.uid and \3.uid = '+uid+' and \3.\4 = \6.\7'
	  elsif p_qstring =~ /(where)/i
	    ret_string = p_qstring.gsub /(where)/i, where_clause + ' and '
	  elsif p_qstring =~ /(group)/i
	    ret_string = p_qstring.gsub /(group)/i, where_clause + ' group '
	  elsif p_qstring =~ /(order)/i
	    ret_string = p_qstring.gsub /(order)/i, where_clause + ' order '
	  else
	    ret_string = p_qstring + where_clause 
	  end
    end
    return ret_string
  end

  
  #Based on current state of @qstatus, determines whether to 
  #display next stage in tutorial, or a specific error page
  def pickdisplay
    path = Rails.root + "app/views/sqlcons/tutorials/"
    #successful query or incrementing section
    tutname = "tut" + session[:tutch].to_s + "-" + session[:tutsec].to_s + ".html"
    #general error
    if @qstatus == 2
	    errname = "qerror.html"
	    @error_name = path + errname
	    #bool to determine views display
	    @waserror = true
    else
	    @waserror = false
    end 
    @lesson_name = path + tutname 
    @help_name = path + "help.html"
  end
end
