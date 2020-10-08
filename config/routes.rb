Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
      get 'users/:id/trips', to: 'users#trips'
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      resources :trips, only: [:show, :create]
      resources :encounters, only: [:show, :create]
      resources :animals, only: [:index, :create]
    end
  end
end