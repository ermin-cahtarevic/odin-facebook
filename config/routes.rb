Rails.application.routes.draw do

  authenticated do
    root 'posts#index'
  end
  root "static_pages#home"

  devise_for :users, :controllers => { registrations: 'registrations' }
  get "/user", to: "users#show"
  get '/users', to: 'users#index'
  post '/friends/create/:id', to: 'friendships#create'
  #delete '/friends/destroy', to: 'friendships#destroy'
  #put '/friends/accept/:id', to: 'friendships#update'
  resources :friendships, only: %i[update destroy index]
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end
  
end
