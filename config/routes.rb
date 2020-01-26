Rails.application.routes.draw do
  get 'topics/new'
  get 'sessions/new'
  root "pages#top"
  
  resources :users
  resources :topics
  resources :comments
  resources :relationships, only: [:create, :destroy]
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  get "likes/index"
  post "/likes", to: "likes#create"
  delete "/likes", to: "likes#destroy"
  
  get "users/:id/message", to: "users#message"
  
end
