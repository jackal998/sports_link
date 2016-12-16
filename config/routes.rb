Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'

  namespace :api, path: '' do
    constraints(host: 'api.localhost') do
      resources :users
    end
    constraints(host: 'api.just.got-game.org') do
      resources :users
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  resources :places

  # devise_scope :user do
  #   authenticated :user do
  #     root 'events#index', as: :authenticated_root
  #   end

  #   unauthenticated do
  #     root 'devise/sessions#new', as: :unauthenticated_root
  #   end
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
    collection do
      get :match
    end
  end
  # root to: "devise/sessions#new"
  root :to => "places#index"
end
