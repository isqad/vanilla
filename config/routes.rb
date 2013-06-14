Vanilla::Application.routes.draw do


  devise_for :users,
             controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
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

    resource :profile, only: [ :show, :update ] do
      resources :notifications, only: [ :index, :destroy ]
    end

    resources :users, only: [ :show ] do
      resources :posts, only: [ :index, :create ]
      resource :friendship, only: [ :show, :create, :update, :destroy ]
    end

    resource :search, only: [ :show ], controller: 'search'

    resources :discussions, only: [ :index, :create ]
  end
  # end API v1

  # Static templates
  namespace :static, defaults: { format: :html } do
    match '*path' => 'templates#show'
  end

  root to: 'pages#home'

end
