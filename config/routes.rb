# -*- coding: utf-8 -*-
EPBook::Application.routes.draw do
    root :to => "users/sessions#login"
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

  devise_scope :user do
    get "/users/login" => "users/sessions#login"
    get "/users/logout" => "users/sessions#logout"
  end

  resources :users do
    get 'resend_email_confirmation', :on => :collection
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
