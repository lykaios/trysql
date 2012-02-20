class SqlconsController < ApplicationController
  # GET /sqlcons
  # GET /sqlcons.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sqlcons }
    end
  end

  #Gets query from input
  def fetchquery
    
    qstring = params[:q]
    #render :text => qstring
	@qresults = ActiveRecord::Base.connection.execute(qstring)
  end

  #Formats onto page
  def show
	respond_to do |format|
	  format.html # show.html.erb
	  format.json { render json: @qresults }
	end
end

    
end
