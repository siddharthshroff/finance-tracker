class Stock < ActiveRecord::Base
  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  
  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name
    
    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end
  
  def self.get_all_info(ticker_symbol)
    stock_all_info = StockQuote::Stock.json_quote(ticker_symbol)
    if stock_all_info
      return stock_all_info
    else
      return nil
    end
  end
  
  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price
    
    last_trade_price = StockQuote::Stock.quote(ticker).last_trade_price_only
    return "#{last_trade_price} (Last Trade)" if last_trade_price 
    'Unavailable'
  end
    
end
