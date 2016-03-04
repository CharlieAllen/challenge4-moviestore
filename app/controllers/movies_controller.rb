class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @cart_action = @movie.cart_action current_user.try :id
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :release_year, :price, :description, :imdb_id, :poster_url)
    end
end
