ActionController::Routing::Routes.draw do |map|

  # The priority is based upon order of creation: first created -> highest priority.
  #map.connect ":controller/:action/:id/:smiles"
  map.root :controller => 'models'
  map.resources :models
  map.resources :servers

end
