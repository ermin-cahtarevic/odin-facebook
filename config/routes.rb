Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get "/user", to: "users#show"
end
