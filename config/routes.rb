EPBook::Application.routes.draw do

  # devise
  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :passwords => "users/passwords"
  }
  # 验证码
  captcha_route

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
  
  resources :phonebooks

  resources :organs, :except => [:destroy] do
    member do
      get 'new_child'
      post 'create_child'
      get 'children_members'
    end
  end

  resources :dashboard, :only=>[:index]

  resources :master, :only => [:index]
  namespace :master do
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

  authenticated :user do
    root :to => 'dashboard#index'
  end
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
end
