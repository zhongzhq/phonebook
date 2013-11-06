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

  resources :organs do
    collection do
      get "manage"
    end
    member do
      get "search"
    end
  end

  resources :users, :except => [:index] do
    member do
      get "with_organ"
      get "with_organ_show"

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

  # resources :follows, :only => [:index, :new, :destroy]

  resources :jobs, :except => [:show]
  resources :addresses, :except => [:show]

  resources :settings
  resources :commons

  resources :user_properties, :only => [:index, :create, :edit]
end
