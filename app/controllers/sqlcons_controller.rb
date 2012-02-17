class SqlconsController < ApplicationController
  # GET /sqlcons
  # GET /sqlcons.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sqlcons }
    end
  end

  #Prints the query back out to page
  def fetchquery
    
    qstring = params[:q]
    render :text => qstring
=begin    
    @course = Course.find_by_sql(qstring)

    respond_to do |format|
     Course.format.html # show.html.erb
      Course.format.json { render json: @course }
    end
=end

  end
    
end
