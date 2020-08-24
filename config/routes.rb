Rails.application.routes.draw do
<<<<<<< HEAD

  resources :comments do

  end

    resource :users, only: [:create]
=======
  
  resources :comments do

  end  
  resource :users, only: [:create]
>>>>>>> 82aeea7d582c544eb3788d9917593d33c2effc47
    post "/login", to: "users#login"
    get "/auto_login", to: "users#auto_login"

    resource :activity do

  end

