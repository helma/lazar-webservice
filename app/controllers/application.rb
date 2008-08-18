# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'lazar'
  skip_before_filter :authorize
  include ExceptionNotifiable
  local_addresses.clear
end
