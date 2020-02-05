Rails.application.routes.draw do

  authenticated do
    root 'posts#index'
  end
  root "static_pages#home"

  devise_for :users, :controllers => { registrations: 'registrations' }
  get "/user", to: "users#show"
  get '/users', to: 'users#index'
  post '/friends/create', to: 'friendships#create'
  delete '/friends/destroy', to: 'friendships#destroy'
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end
  
end
