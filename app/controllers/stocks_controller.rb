class StocksController < ApplicationController
  def show
    @stock = Stock.find(params[:id])
    @stock_all_info = Stock.get_all_info(@stock.ticker) if @stock
  end
  
  
  def search
    if params[:stock]
      @stock = Stock.find_by_ticker(params[:stock])
      @stock ||= Stock.new_from_lookup(params[:stock])
    end
    
    if @stock 
      render partial: 'lookup'
      #render json: @stock
    else
      render status: :not_found, nothing: true
    end
  end
  
end