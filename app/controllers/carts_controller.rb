class CartsController < ApplicationController
	before_action :authenticate_user!
  before_action :fetch_user_cart_movies

  def show
  end

  def add
  	$redis.sadd current_user_cart, params[:movie_id]
  	#render json: current_user.cart_count, status: 200
    redirect_to movie_path(params[:movie_id])
  end

  def remove
  	$redis.srem current_user_cart, params[:movie_id]
  	#render json: current_user.cart_count, status: 200
    redirect_to '/movies'
  end

  def delete
    $redis.del current_user_cart
    redirect_to '/cart'
  end

  private

  def current_user_cart
  	return "cart#{current_user.id}"
  end

  def fetch_user_cart_movies
    @cart_movies = current_user.get_cart_movies
  end
end
