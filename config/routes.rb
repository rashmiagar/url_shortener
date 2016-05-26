Rails.application.routes.draw do
  get 'sessions/new' 
  post 'sessions/' => 'sessions#create', as: :login
  delete 'sessions/' => 'sessions#destroy', as: :logout
  get 'users/new',  as: :signup
  post 'users/' => 'users#create'
  get '/user/:id/' => 'users#show', as: :user
  resources :shortUrl, :controller => "shortener"
  
  root 'users#home'
end
