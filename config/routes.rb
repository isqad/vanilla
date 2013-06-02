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

  namespace :api do
    resources :photos, only: [ :create ], defaults: { format: :json }

    resource :profile, only: [ :show, :update ], defaults: { format: :json } do
      resources :notifications, only: [ :index, :destroy ], defaults: { format: :json }
    end

    resources :users, only: [ :show ], defaults: { format: :json } do
      resources :posts, only: [ :index, :create ], defaults: { format: :json }
      resource :friendship, only: [ :show, :create, :update, :destroy ], defaults: { format: :json }
    end

    resource :search, only: [ :show ], controller: 'search', defaults: { format: :json }
  end

  match 'static/:action', controller: 'static', defaults: { format: :html }

  root to: 'pages#home'

end
