# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  before_filter :authenticate, :except => [:index,:show]

  protected 

  def authenticate
    authorized = false
    if params[:password] && params[:username]
      hashed_password = Digest::MD5.hexdigest(params[:password])
      if User.find_by_name_and_hashed_password(params[:username],hashed_password)
        authorized = true
      end
    end
    render :text => "You are not authorized to perform this action.\n", :status => :unauthorized unless authorized
  end

end
