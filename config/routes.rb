Rails.application.routes.draw do



  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'movies#index'
end
