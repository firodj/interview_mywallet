require "test_helper"

class StockTest < ActiveSupport::TestCase
  test "save stock without name will failed" do
    stock = Stock.new
    assert_not stock.save
  end

  test "save stock with name and company will success" do
    stock = Stock.new
    stock.name = "c3po"
    stock.company = "See Threepio"
    assert stock.save
    assert stock.name == "C3PO"
  end

  test "update stock with already existinng name will failed" do
    stock = stocks(:y2b)
    stock.name = "9s"
    assert_not stock.save
  end
end
