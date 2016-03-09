class UserController < ApplicationController
	before_action :authenticate_user!

	def purchased_movies
		@purchased_movies = current_user.movies 
	end
end
