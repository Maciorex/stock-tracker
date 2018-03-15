Rails.application.routes.draw do

  root "welcome#index"
  devise_for :users, :controllers => { :registrations => 'user/registrations'}
  resources :user_stocks, only: [:create, :destroy]
  resources :users, only: [:show]
  resources :friendships
  get "my_portfolio", to: "users#my_portfolio"
  get "search_stocks", to: "stocks#search"
  get "my_friends", to: "users#my_friends"
  get "search_friend", to: "users#search"
  get "add_friend", to: "users#add_friend"
end
