Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create] do
        get '/trips', to: 'users#trips'
      end
      resources :animals, only: [:index, :create]
      resources :trips, only: [:show, :create]
    end
  end
end
