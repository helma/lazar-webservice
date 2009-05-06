class ModelsController < ApplicationController

  def index
    render :xml => Model.find(:all).to_xml
  end

  def show
    xml = nil
    if params[:smiles] 
      m = Model.find(params[:id])
      if m.ready
        xml = Client.new(m.port,params[:smiles])
      else
        xml = "Model #{m.name} under construction"
      end
    else
      xml = Model.find(params[:id]).to_xml
    end
    render :xml => xml
  end

  def create
    name = File.basename(params[:structure_file].original_filename).sub(/\.smi$/,'')
    regression = true
    regression = false if params[:activity_file].original_filename.match(/\.class$/) 
    model = Model.create(:name => name, :regression => regression)
    FileUtils.mkdir_p(model.data_path)
    FileUtils.cp_r(params[:structure_file].path,model.structure_file)
    FileUtils.cp_r(params[:activity_file].path,model.activity_file)
    pid = fork {
      FeatureDatabase.new(model)
      model.update_attribute(:ready,true)
      Server.new(model)
    }
    Process.detach(pid)
    render :text => model.uri
  end

  def update
    redirect_to :create
  end

end
