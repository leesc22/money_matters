Rails.application.routes.draw do
  root 'sessions#new'

  # Redirect user from Facebook login
  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  get '/sign_up', to: 'users#new'
  resources :users, only: [:show, :edit, :create]
end
