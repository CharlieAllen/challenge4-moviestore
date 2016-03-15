class CartsController < ApplicationController
	before_action :authenticate_user!
  before_action :fetch_user_cart_movies

  def show
  end

  # def test
  #   movie = Movie.all.sample
  #   data = {}
  #   data[:button_label] = "Remove from cart"
  #   data[:movie_name] = movie.title
  #   data[:movie_id] = movie.id
  #   data[:movie_path] = movie_url(movie.id)
  #   data[:cart_action] = add_to_cart_path(movie.id)
  #   respond_to do |format|
  #     # if current_user_cart
  #     format.html { redirect_to movie_path(Movie.last.id) }
  #     format.json { render json: data, status: 200 }
  #     # format.js { render inline: ":movie_id", status: 200 }
  #   end
  # end

  def add
  	$redis.sadd current_user_cart, params[:movie_id]

    movie = Movie.find(params[:movie_id])
    data = {}
    data[:button_label] = "Remove from cart"
    data[:movie_name] = movie.title
    data[:movie_id] = movie.id
    data[:movie_cart_status] = "added to cart."
    data[:movie_path] = movie_url(movie.id)
    data[:cart_action] = remove_from_cart_path(movie.id)
    respond_to do |format|
      format.html { redirect_to movie_path(movie.id) }
      format.json { render json: data }
    end
  end

  def remove
  	$redis.srem current_user_cart, params[:movie_id]

    movie = Movie.find(params[:movie_id])
    data = {}
    data[:button_label] = "Add to cart"
    data[:movie_name] = movie.title
    data[:movie_id] = movie.id
    data[:movie_cart_status] = "removed from cart."
    data[:movie_path] = movie_url(movie.id)
    data[:cart_action] = add_to_cart_path(movie.id)
    respond_to do |format|
      format.html { redirect_to movies_path }
      format.json { render json: data }
    end
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
