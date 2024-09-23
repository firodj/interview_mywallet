namespace :fetch_stock do
  task price_all: :environment do
    r = LatestStockPrice.update(nil)
    puts r
  end
end
