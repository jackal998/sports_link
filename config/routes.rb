Rails.application.routes.draw do

  namespace :api, path: '', :defaults => { :format => :json } do
    constraints(host: ['api.sports-link.online','api.localhost'] ) do
      resources :users, only: [:show] do
        collection do
          post :quit_event
        end
      end
      resources :places, only: [:index, :show]
      resources :events, only: [:new, :create] do
        member do
          post :join
        end
      end
      post "login" => "auth#login"
      post "logout" => "auth#logout"
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show] do
    collection do
      delete :quit_event
    end
  end

  resources :places

  resources :events do
    member do
      post :join
    end
  end

  root :to => "places#index"
end
