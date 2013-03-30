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

  root to: 'pages#home'

end
