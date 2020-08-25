Rails.application.routes.draw do

  resources :favorites, only: [:create, :show, :destroy]
  resources :comments do
  end

  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"


  get "/activities", to: "activity#index"
  get "/activities/:id", to: "activity#show"
  put "/activities/:id", to: "activity#update"
  delete "/activities/:id", to: "activity#destroy"
  post "/activities", to: "activity#create"
end

