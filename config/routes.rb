# -*- coding: utf-8 -*-
EPBook::Application.routes.draw do

  authenticated :user do
    root :to => 'dashboard#index'
  end
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  # devise
  devise_for :users, :controllers => {
    :registrations => "registrations",
    :sessions => "sessions",
    :passwords => "passwords"
  }
  # 验证码
  captcha_route

  resources :phonebooks
  resources :organs, :except => [:destroy] do
    member do
      get 'new_child'
      post 'create_child'
      get 'children_members'
      get 'apply_members'
      get 'pass_user'
      get 'adjust'
      post 'adjust_post'
    end
    collection do
      get 'join'
      post 'join_create'
    end
  end

  resources :dashboard, :only=>[:index]
  namespace :master do
    get "/" => "master#index"
    resources :memberships, :except => [:show, :destroy]
    resources :ranks, :except => [:show, :destroy] do
      member do
        get 'new_child'
        post 'create_child'
      end
    end
    resources :organs do
      member do
        get 'pass'
      end
    end
  end

# API routes
  namespace :api do
    resources :organs,:only=>[] do
      collection do
        get "get_root"
        get "get_organ_tree"
      end
    end
    resources :sessions, :only => [] do
      collection do
        get 'login'
        get 'logout'
        get 'get_user'
      end
    end
    resources :users,:only => [] do
      collection do
        get "get_users"
      end
    end
    resources :versions,:only=>[] do
      collection do
        get "update"
      end
    end
  end

end
