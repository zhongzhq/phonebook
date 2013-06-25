EPBook::Application.routes.draw do

  resources :phonebooks

  root :to => 'dashboard#index'

  mount Unirole::Engine => '/unirole', as: 'unirole_app'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
