Mocket::Application.routes.draw do
  root :to => 'pages#show', id: 'main'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  get '/logout', :to => 'sessions#destroy'
  get '/login' => redirect { '/auth/google_oauth2' }


  get '/archives', to: 'users#archives', as: "archives"
  get '/dashboard', to: 'users#dashboard', as: "dashboard"
  get '/favorites', to: 'users#favorites', as: "favorites"
  get '/settings', to: 'users#settings', as: "settings"
end
