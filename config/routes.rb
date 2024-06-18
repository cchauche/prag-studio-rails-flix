Rails.application.routes.draw do
  resources :favorites
  root "movies#index"

  resources :movies do
    resources :reviews
  end

  resource :session, only: %i[create destroy new]

  resources :users
  get "signup" => "users#new"
  get "signin" => "sessions#new"
end
