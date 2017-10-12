Rails.application.routes.draw do
  root 'users#show'

  get '/sign_up', to: 'users#new'
  post '/users', to: 'users#create'
end
