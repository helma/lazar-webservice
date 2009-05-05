class EndpointsController < ApplicationController

  def index
    render :xml => Endpoint.find(:all).to_xml(:only => [:uri], :methods => [:uri])
  end

  def show
    xml = nil
    if params[:smiles] 
      e = Endpoint.find_by_name(params[:endpoint])
      xml = Client.new(e.port,params[:smiles])
    else
      xml = Endpoint.find_by_name(params[:endpoint]).to_xml(:include => [:prediction_type])
    end
    render :xml => xml
  end

  def loo
    e = Endpoint.find_by_name(params[:endpoint])
    render :xml => YAML.load(File.open("#{e.validation_path}/summary.yaml")).to_xml
  end

end
