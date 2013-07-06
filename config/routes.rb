EPBook::Application.routes.draw do

  captcha_route

  resources :users do
    collection do
      get 'register'
      get 'activate'
      get 'confirm'
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
