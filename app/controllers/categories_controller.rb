class CategoriesController < ApplicationController

  def index
    render :xml => Category.find(:all).to_xml
  end

end
