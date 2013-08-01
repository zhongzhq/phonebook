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
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :passwords => "users/passwords"
  }

  # 验证码
  captcha_route

  resources :phonebooks

  resources :public, :only => [] do
    collection do
      get 'help'
      get 'about'
      get 'version'
    end
  end

  resources :users, :only => [] do
    collection do
      get 'edit_info'
      put 'update_info'
    end
    member do
      get 'adjust'
      put 'adjust_post'
    end
  end

  resources :organs, :except => [:destroy] do
    member do
      get 'new_child'
      post 'create_child'
      get 'apply_members'
      get 'pass_user'
      get 'add_member'
      post 'save_member'
    end
    collection do
      get 'join'
      post 'join_create'
      get 'new_member'
      post 'create_member'
    end
  end

  # Master routes
  namespace :master do
    root :to => 'master#index'
    resources :memberships, :except => [:show, :destroy]
    resources :ranks, :except => [:show, :destroy] do
      member do
        get 'new_child'
        post 'create_child'
      end
    end
    resources :organs,:only=>[:index] do
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
        get "all_users"
      end
    end
    resources :versions,:only=>[] do
      collection do
        get "update"
      end
    end
  end

end
