Rails.application.routes.draw do
  root to: "businesses#index"

  get 'ui(/:action)', controller: 'ui'

	get '/login', to: 'sessions#new'
	resources :sessions, only: [:create]
	get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'

	get '/recent', to: 'reviews#index'  

  resources :businesses, only: [:index, :show, :new, :create] do
  	resources :reviews, only: [:index, :create]
  end

  resources :users, only: [:show, :create]
end