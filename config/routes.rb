EPBook::Application.routes.draw do

  resources :users do
    collection do
      get 'sign_in'
    end
  end

  resources :phonebooks
  resources :ranks
  resources :organs
  resources :memberships
  resources :dashboard, :only=>[:index]

  resources :default, :only => [:index] do
    collection do
      post 'login'
      get 'logout'
    end
  end

  root :to => 'default#index'
end
