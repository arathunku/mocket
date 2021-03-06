Mocket::Application.routes.draw do
  root :to => 'pages#show', id: 'main'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  get '/logout', :to => 'sessions#destroy'
  get '/login' => redirect { '/auth/google_oauth2' }


  get '/dashboard', to: 'users#dashboard', as: "dashboard"
  post '/dashboard', to: 'users#new_song'
  get '/archives', to: 'users#archives', as: "archives"
  put '/posts/:id/archive', to: 'users#archive', as: "archive"
  get '/favorites', to: 'users#favorites', as: "favorites"
  put '/posts/:id/favorite', to: 'users#favorite', as: "favorite"
  delete '/posts/:id', to: 'users#destroy_song', as: "post"
  get "/posts/export", to: "users#export", as: "export"

  post '/api/song', to: 'users#new_api_song'
  get '/api/history', to: 'users#history', as: "history"

  get '/settings', to: 'settings#default', as: "settings"
  patch '/settings', to: 'settings#update'
  get '/settings/api', to: 'settings#api', as: "settings_api"

end
