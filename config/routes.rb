Vanilla::Application.routes.draw do

  devise_for :users,
             controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations',
                 passwords: 'passwords',
                 unlocks: 'unlocks',
                 confirmations: 'confirmations'
             },
             path: 'user',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 sign_up: 'register'
             }

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

    resource :search, only: [ :show ], :controller => 'search'

    resources :discussions, only: [ :index, :create ]
  end
  # end API v1

  # Static templates
  namespace :static, defaults: { format: :html } do
    match '*path' => 'templates#show'
  end

  authenticated :user do
    root :to => 'pages#home', :as => :authenticated_root
  end

  root :to => redirect('/user/login')

end
