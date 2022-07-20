Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get 'static_pages/home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post '/add_to_cart/:id', to: 'carts#add_to_cart', as: 'add_to_cart'
  delete '/remove_from_cart/:id', to: 'carts#remove_from_cart', as: 'remove_from_cart'

  get '/carts', to: "carts#index"
  resources :users do
    member do
      get :buy
    end
  end
  resources :books
  resources :users
  get '/order', to: 'orders#index'
  resources :carts
  resources :filter_books do
    member do
      get :buy
    end
  end
  get "/search", to: "static_pages#search"
  resources :comments, only: [:create, :destroy]
end
