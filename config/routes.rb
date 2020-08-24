Rails.application.routes.draw do
  Rails.application.routes.draw do
    resource :users, only: [:create]
    post "/login", to: "users#login"
    get "/auto_login", to: "users#auto_login"
    resource :activity do
  end
end
