Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :api, path: '' do
    constraints(host: 'api.localhost') do
      resources :users
    end
  end

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
