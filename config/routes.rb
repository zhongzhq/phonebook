# -*- coding: utf-8 -*-
EPBook::Application.routes.draw do

  authenticated :user do
    root :to => "dashboards#index"
  end
  unauthenticated :user do
    devise_scope :user do
      root :to => "users/sessions#new"
    end
  end

  # public
  resources :downloads, :only => [:index]
  resources :news, :only => [:index]
  resources :helps, :only => [:index]

  # devise
  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions"
  }

  resources :dashboards, :only => [:index]

  resources :users do
    collection do
      get 'new_user'
      post 'create_user'
    end
    # get 'resend_email_confirmation', :on => :collection
    member do
      get 'adjust'
      put 'adjust_post'
    end
  end

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

  resources :memberships, :except => [:show]
  # api
  mount API => 'api'
end
