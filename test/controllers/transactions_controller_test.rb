require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url, headers: { Authorization: "Plain system" }, as: :json
    assert_response :success
  end

  test "should show transaction" do
    get transaction_url(@transaction), headers: { Authorization: "Plain system" }, as: :json
    assert_response :success
  end
end
