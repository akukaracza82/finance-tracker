class UserStocksController < ApplicationController
  def create
    @user_stock = UserStock.create
  end
end
