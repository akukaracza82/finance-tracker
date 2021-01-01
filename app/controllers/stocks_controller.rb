class StocksController < ApplicationController
  def search
    if params[:stock].present? // has it not been left blank??
      @stock = Stock.new_lookup(params[:stock])
        if @stock // if stock.rb did not return nil.
          render 'users/my_portfolio'
        else
          flash[:alert] = "Please enter a valid symbol to search"
          redirect_to my_portfolio_path
        end
    else
        flash[:alert] = "This field canot be left blank"
        redirect_to my_portfolio_path
    end
  end
end
