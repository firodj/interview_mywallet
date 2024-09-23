require "test_helper"

class WalletsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wallet = wallets(:john)
    @stock_wallet = wallets(:y2b)
  end

  test "system should list all wallets" do
    get wallets_url, headers: { Authorization: "Plain system" }, as: :json
    assert_response :success, response.body
  end

  test "system should show wallet" do
    get wallet_url(@wallet), headers: { Authorization: "Plain system" }, as: :json
    assert_response :success, response.body
  end

  test "system should deposit stock wallet" do
    get wallet_deposit_url(@stock_wallet),
      params: { deposit: { amount: 2.22 } },
      headers: { Authorization: "Plain system" }, as: :json
    assert_response :success, response.body
  end

  test "system should withdraw stock wallet" do
    get wallet_withdraw_url(@stock_wallet),
      params: { withdraw: { amount: 2.22 } },
      headers: { Authorization: "Plain system" }, as: :json
    assert_response :success, response.body
  end
end
