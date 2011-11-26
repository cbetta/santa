Santa::Application.routes.draw do
  resources :picks

  resources :participants

  resources :draws

  resources :connections

  resources :users

  match "/login" => "users#new", :as => "login"
  match "/logout" => "users#destroy"
  match "/auth/:provider/callback" => "users#create"
  root :to => 'draws#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
