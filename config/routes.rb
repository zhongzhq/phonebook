EPBook::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }

  captcha_route

  resources :users do
    collection do
      get 'register'
      get 'activate'
      get 'confirm'
      get 'resend_mail'
    end
  end

  resources :phonebooks
  resources :ranks
  resources :organs do
    collection do
      get "get_organ"
    end
  end

  resources :dashboard, :only=>[:index]

  resources :master,:only=>[:index] do
    collection do
      resources :memberships
    end
  end

  resources :default, :only => [:index] do
    collection do
      post 'login'
      get 'logout'
    end
  end

  root :to => 'dashboard#index'
end
