Rails.application.routes.draw do

  namespace :api, path: '', :defaults => { :format => :json } do
    constraints(host: ['api.localhost', 'api.sports-link.online'] ) do
      resources :users
      resources :places
      resources :events
      post "login" => "auth#login"
      post "logout" => "auth#logout"
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :places

  resources :events

  get "sportmate" => "events#show"

  root :to => "places#index"
end
