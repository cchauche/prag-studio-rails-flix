Rails.application.routes.draw do
  resources :genres
  root "movies#index"

  resources :movies do
    resources :favorites, only: %i[create destroy]
    resources :reviews
  end

  resource :session, only: %i[create destroy new]

  resources :users
  get "signup" => "users#new"
  get "signin" => "sessions#new"
end
