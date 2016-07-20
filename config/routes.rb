Rails.application.routes.draw do
 
  get '/movies/search', to: 'movies#search'

  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create]

  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'movies#index'
end
