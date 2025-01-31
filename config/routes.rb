Rails.application.routes.draw do
  root "static_pages#top"
  resources :users, only: %i[new create]
  resources :clinics, only: %i[index new create show edit destroy update]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  resources :products, only: %i[index new create edit destroy update]
  resources :tasks, only: %i[index new create destroy]
end
