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
    resources :photos, only: [ :create, :show ], defaults: { format: :json }

    resource :profile, only: [ :show, :update ], defaults: { format: :json }

    resources :users, only: [ :show ], defaults: { format: :json } do
      resources :posts, only: [ :index ], defaults: { format: :json }
    end
  end

  root to: 'pages#home'

end
