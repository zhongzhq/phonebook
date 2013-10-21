# -*- coding: utf-8 -*-
Phonebook::Application.routes.draw do
  # 设置用户登陆前后不同的 root  
  root :to => 'publics#index', :constraints => ->(request) do
    User.find_by_auth_token(request.cookies["remember"]) or request.session[:user_id]
  end
  root :to => 'publics#login'

  resources :publics do
    collection do
      post 'authenticate'
      delete 'logout'

      post "search"
    end
  end

  resources :organs, :except => [:index, :destroy]

  resources :users, :except => [:index, :destroy] do
    member do
      get "reset"
      post "reset_submit"
      
      get "password"
      post "password_submit"
      get "info"
      post "info_submit"
    end
  end

  resources :follows, :only => [:index, :new, :destroy]

  resources :memberships, :except => [:show] do
    collection do
      delete "index"
    end
  end
end
