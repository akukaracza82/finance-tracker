class StocksController < ApplicationController
  def search
    if params[:stock].present? # has it not been left blank??
      @stock = Stock.new_lookup(params[:stock])
        if @stock # if stock.rb did not return a nil from rescue action
          respond_to do |format|
            format.js { render partial: 'users/result' }
          end
        else
          respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/result' }
          end
        end
    else
      respond_to do |format|
      flash.now[:alert] = "This field canot be left blank"
      format.js { render partial: 'users/result' }
      end
    end
  end
end
