Rails.application.routes.draw do
  root to: "tasks#index" 
 
  get "signup", to: "users#new"
  resources :users, only: [:new, :create]
 
  resources :tasks
end
