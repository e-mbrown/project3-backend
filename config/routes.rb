Rails.application.routes.draw do

  resources :favorites, only: [:show, :destroy, :index]
  resources :comments do
  end

  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

  post "/users/comments/:id", to: "comments#create"
  get "/users/comments/:id", to: "comments#index"

  get "/activities", to: "activity#index"
  get "/activities/:id", to: "activity#show"
  get "/activities/q/:location", to: "activity#activity_by_location"
  put "/activities/:id", to: "activity#update"
  delete "/activities/:id", to: "activity#destroy"
  post "/activities", to: "activity#create"

  # post "/favorites/", to: "favorites#create"
  # patch "/favorites/:id", to: "favorites#toggle"
  post "/favorites/:id", to: "favorites#toggle"

end

