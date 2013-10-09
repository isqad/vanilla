Vanilla::Application.routes.draw do

  resource :user_session, :only => [ :new, :create, :destroy ]
  resource :password, :only => [ :new, :create, :edit, :update ]
  resource :registration, :only => [ :new, :create ]

  # API v1
  namespace :api, defaults: { format: :json } do
    resources :photos, only: [ :create, :show ]

    resource :profile, only: [ :update, :show ] do
      resources :notifications, only: [ :index, :destroy ]
    end

    resources :users, :only => [ :show, :index ] do

      resources :posts, :only => [ :index, :create, :destroy ] do
        member do
          put 'recover'
        end
      end

      resources :friendships, :only => [ :create, :update, :destroy ]
    end

    resources :friendships, :only => [ :index ]

    resource :search, only: [ :show ], :controller => 'search'

    resources :discussions, only: [ :index, :create ]
  end
  # end API v1

  # Static templates
  namespace :static, defaults: { format: :html } do
    match '*path' => 'templates#show'
  end

  # For logged in user
  constraints(LoggedInConstraint) do
    root :to => 'pages#home', :as => :authenticated_root
  end

  # Redirect to login form by default
  root :to => 'user_sessions#new'

end
