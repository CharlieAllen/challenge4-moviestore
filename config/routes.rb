Rails.application.routes.draw do
  resources :movies, only: [:show, :index]

  root 'movies#index'
end
