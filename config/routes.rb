# -*- coding: utf-8 -*-
Phonebook::Application.routes.draw do
  # 设置用户登陆前后不同的 root
  root :to => 'publics#login', :constraints => ->(request) { request.session[:user_id].blank? }
  root :to => 'publics#index'

  resources :publics do
    collection do      
      post 'authenticate'
      delete 'logout'
    end
  end

  resources :organs, :except => [:index, :destroy] do
    collection do
      post 'search'
    end
  end

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
