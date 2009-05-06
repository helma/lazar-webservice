ActionController::Routing::Routes.draw do |map|

  # The priority is based upon order of creation: first created -> highest priority.
  map.root :controller => 'models'
  map.resources :models
end
