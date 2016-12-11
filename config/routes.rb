Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
    collection do
      get :match
    end
  end
  root :to => "events#index"
end
