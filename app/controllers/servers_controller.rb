class ServersController < ApplicationController
  
  def index
    render :xml => Server.find(:all).to_xml
  end

  def show
    render :xml => Server.find(params[:id]).to_xml
  end

  def create
    server = Server.create(:model => Model.find(params[:model_id]))
    server.start
    render :xml => server.to_xml
  end

  def destroy
    server = Server.find(params[:id])
    server.stop
    server.destroy
    render :text => "Server with ID=#{server.id} stopped\n"
  end

end
