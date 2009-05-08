require 'digest/md5'
class ModelsController < ApplicationController

  def index
    begin
      render :xml => Model.find(:all).to_xml, :status => :ok
    rescue
      render :text => "Internal error", :status => :internal_server_error
    end
  end

  def show
    begin
      model = Model.find(params[:id])
      if params[:smiles] # predict
        begin
          render :xml => Client.new(model,URI.unescape(params[:smiles])), :status => :ok
        rescue
          render :text => "Starting server for model with ID=#{model.id}. Please try again later.\n", :status => :service_unavailable
        end
      else # show
        begin
          render :xml => model.to_xml, :status => :ok
        rescue
          render :text => "XML conversion failed\n", :status => :internal_server_error
        end
      end
    rescue 
      render :text => "Couldn't find Model with ID=#{params[:id]}.\n", :status => :not_found
    end
  end

  def create

    begin
      name = File.basename(params[:activity_file].original_filename).sub(/\..*$/,'')
      activity_data = File.open(params[:activity_file].path,'r').readlines

      # guess classification/regression from input file
      regression = true
      regression = false if activity_data.collect{|line| line.split(/\s+/)[1].to_i}.uniq.sort == [0,1]

      model = Model.create(:name => name, :regression => regression, :user => session[:user])
      FileUtils.mkdir_p(model.data_path)
      FileUtils.cp_r(params[:structure_file].path,model.structure_file)

      # convert activity file from 2 to 3 columns
      File.open(model.activity_file,'w') do |activity_file|
        activity_data.each do |line|
          items = line.chomp.split(/\s+/)
          activity_file.puts "#{items[0]}\t\"#{name}\"\t#{items[1]}\n"
        end
      end
      #FileUtils.cp_r(params[:activity_file].path,model.activity_file)
      pid = fork { FeatureDatabase.new(model) }
      Process.detach(pid)
      render :xml => model.to_xml, :status => :ok
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
      render :text => "Model with ID=#{id} deleted!\n", :status => :ok
    rescue
      render :text => "Could not delete model with ID=#{id}.\n", :status => :internal_server_error
    end
  end

end
