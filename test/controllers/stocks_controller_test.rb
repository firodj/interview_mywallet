require "test_helper"

class StocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock = stocks(:y9s)
  end

  test "should get index" do
    get stocks_url, headers: { Authorization: "Plain system" }, as: :json
    assert_response :success
  end

  test "should create stock" do
    assert_difference("Stock.count") do
      post stocks_url, params: { stock: { name: "GOTO", company: "GoTo Gojek Tokopedia" } },
        headers: { Authorization: "Plain system" },
        as: :json
    end

    assert_response :created
  end

  test "should show stock" do
    get stock_url(@stock),
      headers: { Authorization: "Plain system" },
      as: :json
    assert_response :success
  end

  test "should update stock" do
    patch stock_url(@stock), params: { stock: { name: "b2b", company: "Business Two Business" } },
      headers: { Authorization: "Plain system" },
      as: :json
    assert_response :success
  end

  test "should destroy stock" do
    assert_difference("Stock.count", -1) do
      delete stock_url(@stock),
        headers: { Authorization: "Plain system" },
        as: :json
    end

    assert_response :no_content
  end
end
