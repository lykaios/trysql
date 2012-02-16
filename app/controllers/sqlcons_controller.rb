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
    render :text => params[:q]
  end
    
end
