require 'digest/md5'
require 'rest_client'

class ModelsController < ApplicationController

  def index
    begin
      render :text => Model.find(:all).collect { |model| "http://" + request.host + request.port_string + request.request_uri + model.id.to_s }.join("\n"), :status => :ok
    rescue
      render :text => "Index not found", :status => :not_found
    end
  end

  def show
    begin
      @model = Model.find(params[:id])
      if params[:smiles] # predict
        begin
          @prediction = Client.new(@model,URI.unescape(params[:smiles]))
          render :xml => @prediction, :status => :ok
        rescue
          render :text => "Can not start server for model with ID #{@model.id}.\n", :status => :service_unavailable
        end
      else # show
        respond_to do |format|
          format.xml
        end
      end
    rescue 
      render :text => "Couldn't find Model with ID #{params[:id]}.\n", :status => :not_found
    end
  end

  def create

    begin
      activity_name = params[:name]
      training_data = params[:file].readlines

      # guess classification/regression from input file
      regression = true
      regression = false if training_data.collect{|line| line.split(/\s+/)[2].to_i}.uniq.sort == [0,1]

      model = Model.create(:name => activity_name, :regression => regression, :user => session[:user])
      FileUtils.mkdir_p(model.data_path)

      # convert activity file from 2 to 3 columns
      activity_file = File.open(model.activity_file,'w')
      structure_file = File.open(model.structure_file,'w')
      training_data.each do |line|
        begin
          items = line.chomp.split(/\s+/)
          id = items[0]
          smiles = items[1]
          activity = items[2]
          structure_file.puts "#{id}\t#{smiles}\n"
          activity_file.puts "#{id}\t\"#{activity_name}\"\t#{activity}\n"
          puts "#{id}\t#{smiles}\t#{activity}\n"
        rescue
        end
      end

      activity_file.close
      structure_file.close
      
      pid = fork do
        FeatureDatabase.new(model) 
        Validation.new(model)
      end
      Process.detach(pid)
      render :text => "http://" + request.host + request.port_string + request.request_uri + model.id.to_s, :status => :ok
    rescue
      render :text => "Failed to create new model\n", :status => :internal_server_error
    end

  end

  def update
    model = Model.find(params[:id]).destroy
    create
  end

  def destroy
    begin
      model = Model.find(params[:id])
      id = Model.id
      Server.stop(model.port)
      FileUtils.rm_r(File.dirname(model.structure_file))
      model.destroy
      render :text => "Model with ID #{id} deleted!\n", :status => :ok
    rescue
      render :text => "Could not delete model with ID #{id}.\n", :status => :internal_server_error
    end
  end

end
