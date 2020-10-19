Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      get '/users/:id/trips', to: 'users#trips'
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      post 'friendship', to: 'users#friendship'
      post 'unfriend', to: 'users#unfriend'
      get '/users/:id/followings', to: 'users#followings'
      resources :trips, only: [:index, :show, :create, :update, :destroy]
      get '/trips/:id/encounters', to: 'trips#encounters'
      resources :encounters, only: [:show, :create, :update, :destroy]
      patch '/encounters/:id/photos', to: 'encounters#add_photos'
      resources :animals, only: [:index, :create]
    end
  end
end