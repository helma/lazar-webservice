ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  #map.connect '', :controller => "lazar", :action => "index"

  #map.connect ':category/:endpoint/:action/:smiles', :controller => "lazar"
  #map.resources :endpoint
  #map.connect ':endpoint', :controller => "endpoints", :action => "show"
  map.connect 'endpoints', :controller => "endpoints", :action => "index"
  map.connect 'categories', :controller => "categories", :action => "index"
  map.connect ':category/:database/:endpoint', :controller => "endpoints", :action => "show"
  map.connect ':category/:database/:endpoint/loo', :controller => "endpoints", :action => "loo"
  #map.connect ':category/:action', :controller => "lazar"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'

  # dynamic stylesheet
  #map.connect 'stylesheets/:rcss', :controller => 'stylesheets', :action => 'rcss'
  #map.from
end
