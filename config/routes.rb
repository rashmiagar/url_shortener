Rails.application.routes.draw do
  get 'sessions/new' 
  post 'sessions/' => 'sessions#create', as: :login
  delete 'sessions/' => 'sessions#destroy', as: :logout
  get 'users/new',  as: :signup
  post 'users/' => 'users#create'
  get '/user/:id/' => 'users#show', as: :user
  resources :shortUrl, :controller => "shortener"
  
  root 'users#home'

  namespace :api, constraints: {format: "json"} do
  	resources :shortUrl, :controller => "shortener", :only => [:index, :create, :destroy] do
  	  collection do
  	  	post "track" => "shortener#track"
  	    post "untrack" => "shortener#untrack"
	  end
	end
  end
end
