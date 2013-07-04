EPBook::Application.routes.draw do

  resources :phonebooks
  resources :ranks do
    collection do
      get 'new_root'
    end
  end
  resources :organs
  root :to => 'default#index'
  resources :dashboard,:only=>[:index]
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
