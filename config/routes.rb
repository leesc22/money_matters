Rails.application.routes.draw do
  root 'investments#new'

  resources :account_activations, only: [:edit]

  resources :articles

  resources :investments, except: [:edit, :update]

  # Redirect user from Facebook login
  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  get '/sign_up', to: 'users#new'
  resources :users, only: [:show, :edit, :create, :update]
end
