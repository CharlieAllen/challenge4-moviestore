Rails.application.routes.draw do
  get 'carts/show'

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  resources :movies, only: [:show, :index]

  root 'movies#index'
end
