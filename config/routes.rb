EPBook::Application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :passwords => "users/passwords"
  }

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
  end

  captcha_route

  resources :users

  resources :phonebooks

  resources :organs do
    collection do
      get 'join'
      post 'join_create'
    end
  end

  resources :dashboard, :only=>[:index]

  resources :master,:only=>[:index] do
    collection do

      resources :memberships
      resources :ranks
    end
  end

  resources :default, :only => [:index] do
    collection do
      post 'login'
      get 'logout'
    end
  end

  authenticated :user do
    root :to => 'dashboard#index'
  end
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
end
