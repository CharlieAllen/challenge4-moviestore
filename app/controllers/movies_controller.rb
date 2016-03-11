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
    @cart_action = @movie.cart_action current_user.try :id
  end

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end
  end

end
