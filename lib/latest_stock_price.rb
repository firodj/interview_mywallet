require 'latest_stock_price/fetcher'

module LatestStockPrice
  class Error < StandardError; end

  def self.update(identifier)
    Fetcher.new(identifier).fetch
  end
end
