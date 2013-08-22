  # -*- coding: utf-8 -*-
EPBook::Application.routes.draw do
  root :to => 'public#index'

  # 验证码
  captcha_route

  # public
  resources :products, :only => [:index]
  resources :clouds, :only => [:index]
  resources :downloads, :only => [:index]
  resources :news, :only => [:index]
  resources :helps, :only => [:index]
  resources :purchases, :only => [:index]
  
  # devise
  begin
    devise_for :users, :controllers => {
      :registrations => "users/registrations",
      :sessions => "users/sessions"
    }
  rescue Exception => e;end

  resources :dashboards, :only => [:index]

  devise_scope :user do
    get "/users/login" => "users/sessions#login"
    get "/users/logout" => "users/sessions#logout"
  end
  

  resources :users do
    get 'resend_email_confirmation', :on => :collection
  end

  # resources :users, :only => [:index] do
  #   collection do
  #     get 'edit_info'
  #     put 'update_info'
  #     get 'resend_email_confirmation'
  #   end
  #   member do
  #     get 'adjust'
  #     put 'adjust_post'
  #   end
  # end

  resources :organs, :except => [:destroy] do
    member do
      get 'remove_member'
    end
    collection do
      get 'new_member'
      post 'create_member'
      get 'search'
    end
  end

  resources :memberships

  resources :user_applies, :only => [:index, :new, :create, :update] do
    collection do
      get 'children_organs'
      get 'memberships'
    end
  end
  resources :organ_applies, :except => [:show] do
    member do
      get 'check'
    end
  end

  # Master routes
  namespace :master do
    root :to => 'home#index'
    resources :organs, :only => [:index, :update]
    resources :systems, :only => [:index]
  end

  mount API => 'api'
end

=begin
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
=end
