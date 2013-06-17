Phonebook::Application.routes.draw do
  resources  :phonebooks

  root :to => 'dashboard#index'

  # match ':controller(/:action(/:id))(.:format)'
end
