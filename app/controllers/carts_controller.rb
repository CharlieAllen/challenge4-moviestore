class CartsController < ApplicationController
	before_action :authenticate_user!

  def show
  	cart_ids = $redis.smembers current_user_cart
  	@cart_movies = Movie.find(cart_ids)
  end

  def add
  	$redis.sadd current_user_cart, params[:movie_id]
  	render json: current_user_cart.cart_count, status: 200
  end

  
end
