class CartsController < ApplicationController
	before_action :authenticate_user!

  def show
  	cart_ids = $redis.smembers current_user_cart
  	@cart_movies = Movie.find(cart_ids)
  end

  
end
