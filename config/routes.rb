Rails.application.routes.draw do
  root "static_pages#top"
  get "terms_of_use", to: "static_pages#terms_of_use"
  get "privacy_policy", to: "static_pages#privacy_policy"
  resources :users, only: %i[new create]
  resources :clinics, only: %i[index new create show edit destroy update]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  resources :products, only: %i[index new create edit destroy update]
  resources :submissions, only: %i[new create]
  resources :tasks, only: %i[index new create destroy] do
    collection do
      post :auto_schedule
      get :auto_schedule
    end
  end
  resources :password_resets, only: [ :create, :edit, :update, :new ]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  post "/auth/google_oauth2/callback", to: "user_sessions#google_auth"
  get "/auth/google_oauth2/callback", to: "user_sessions#google_auth"
  post "/auth/failure", to: redirect("/")
end
