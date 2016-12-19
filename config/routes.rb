Rails.application.routes.draw do

  namespace :api, path: '' do
    constraints(host: 'api.localhost') do
      resources :users
      resources :places
      resources :events
    end
    constraints(host: 'api.sports-link.online') do
      resources :users
      resources :places
      resources :events
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :places

  resources :events

  root :to => "places#index"
end
