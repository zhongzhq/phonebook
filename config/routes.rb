EPBook::Application.routes.draw do

  get "users/index"

  resources :phonebooks
  resources :ranks
  resources :organs
  root :to => 'default#index'
  resources :dashboard,:only=>[:index]
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
