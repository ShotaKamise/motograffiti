Rails.application.routes.draw do
  
  get 'topics/new'
  get 'sessions/new'
  root "pages#top"
  
  get 'topics/search', to: 'topics#search'
  
  resources :users
  resources :topics
  resources :comments
  resources :relationships, only: [:create, :destroy]
  resources :rooms, only: [:create, :show]
  resources :messages, only: [:create]
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  get "/likes/index", to: "likes#index"
  post "/likes", to: "likes#create"
  delete "/likes", to: "likes#destroy"
  
  get "/relationships/:id/index", to: "relationships#index"
  
  mount ActionCable.server => '/cable'
  
end
