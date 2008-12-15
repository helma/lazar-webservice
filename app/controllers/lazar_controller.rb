class LazarController < ApplicationController

  layout 'lazar'

  def index
    @endpoints = LazarModule.find(:all)
    respond_to do |format|
      format.xml { render :xml => @endpoints.to_xml }
    end
  end

  def show
    errors = {}
    if @module = LazarModule.find_by_directory("public/data/#{params[:category]}/#{params[:endpoint]}")
      if !params[:smiles].blank? 
        begin
          Obmol.new(params[:smiles]) # invalid smiles should fail here
          begin
            @lazar = Lazar.new(@module.id)
            @lazar.predict(params[:smiles])
          rescue
            errors[:error] = "lazar prediction for smiles '" + params[:smiles] + "' failed."
          end
        rescue
            errors[:error] = "Could not parse smiles '" + params[:smiles] + "'."
        end
      else
        errors[:error] = "No structure provided"
      end
    else
      errors[:error] = "No lazar model for #{params[:category]}/#{params[:endpoint]}"
    end

    respond_to do |format|
      format.xml do
        if @lazar
          render :xml => @lazar.to_xml
        else
          render :xml => errors.to_xml
        end
      end
    end
  end

end
