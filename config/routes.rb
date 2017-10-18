Rails.application.routes.draw do
  root 'investments#new'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  # Redirect user from Facebook login
  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'
  resources :users, only: [:show, :edit, :create, :update]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :investments, except: [:edit, :update]
  resources :articles
end
