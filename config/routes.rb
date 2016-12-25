Rails.application.routes.draw do

  namespace :api, path: '', :defaults => { :format => :json } do
    constraints(host: ['api.sports-link.online','api.localhost'] ) do
      resources :users
      resources :places
      resources :events do
        member do
          post :join
        end
      end
      post "login" => "auth#login"
      post "logout" => "auth#logout"
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :places

  resources :events do
    member do
      post :join
    end
  end

  get "sportmate" => "events#show"

  root :to => "places#index"
end
