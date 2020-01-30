Rails.application.routes.draw do

  authenticated do
    root 'posts#index'
  end
  root "static_pages#home"

  devise_for :users, :controllers => { registrations: 'registrations' }
  get "/user", to: "users#show"
  get '/users', to: 'users#index'
  resources :posts
  
end
