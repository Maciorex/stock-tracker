class StocksController < ApplicationController

  def search
    if params[:stock].blank?
      flash.now[:danger] = "Empty search string "
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "Wrong symbol entered " unless @stock
    end
    respond_to do |format|
      format.js {render partial: "users/result"}
    end
  end
end
