Rails.application.routes.draw do
	  root 'movies#index'

		#get 'carts/show'

	devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
	resources :movies, only: [:show, :index]
	resources :transactions, only: [:new, :create]

	resource :cart, only: [:show, :delete] do
	  put 'add/:movie_id', to: 'carts#add', as: :add_to
	  put 'remove/:movie_id', to: 'carts#remove', as: :remove_from
	  delete 'destroy', to: 'carts#delete', as: :empty
	end

	get '/test', to: 'carts#test'

	get 'mymovies', to: 'user#purchased_movies', as: :user_movies
end
