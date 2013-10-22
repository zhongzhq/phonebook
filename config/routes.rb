# -*- coding: utf-8 -*-
Phonebook::Application.routes.draw do
  # 设置用户登陆前后不同的 root  
  root :to => 'publics#index', :constraints => ->(request) do
    User.find_by_authentication_token(request.cookies["remember"]) or User.find_by_id(request.session[:user_id])
  end
  root :to => 'publics#login'

  resources :publics do
    collection do
      post 'authenticate'
      delete 'logout'

      get "search"
    end
  end

  resources :organs, :except => [:destroy] do
    collection do
      get "manage"
    end
  end

  resources :users, :except => [:index, :destroy] do
    member do
      # 管理员操作
      get "reset"
      post "reset_submit"
      
      # 个人操作
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

  resources :settings
end
