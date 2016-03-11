class MoviesController < ApplicationController

  def index
  	user_movies = 
  		if current_user
  			current_user.movies
  		else 
  			[]
  		end

    all_movies = Movie.all
    @movies = all_movies - user_movies

    @cart_movies =
    if current_user
    	current_user.get_cart_movies
    else
    	[]
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @can_add_to_cart = !(@movie.cart_action current_user.try :id)
  end
end
