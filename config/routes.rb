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

  resources :users
end
