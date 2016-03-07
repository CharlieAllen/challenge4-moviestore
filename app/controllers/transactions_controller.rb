class TransactionsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_cart!
  def new
  end
end
