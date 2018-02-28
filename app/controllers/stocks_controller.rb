class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js {render partial: 'users/result'}
        end
      else
        respond_to do |format|
          flash.now[:danger] = "Wrong symbol entered"
          format.js {render partial: "users/result"}
        end
      end
    else
      respond_to do |format|
        flash.now[:danger] = "Empty search string"
        format.js {render partial: "users/result"}
      end
    end
  end
end
