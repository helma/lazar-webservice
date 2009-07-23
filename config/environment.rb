# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.plugins = [:all]
  config.action_controller.session = { :session_key => "_myapp_session", :secret => "5088f3e9d90958b1a8d2f5832f00e8ed" }
  config.load_paths += %W( #{RAILS_ROOT}/lib/lazar )
  config.action_controller.session_store = :active_record_store

end

COMPOUNDS_SERVICE_URI = "http://webservices.in-silico.ch/compounds/"
