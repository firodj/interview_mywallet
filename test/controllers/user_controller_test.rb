require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "user should get wallet" do
    get user_wallet_url, headers: { Authorization: "Plain john@example.com"}, as: :json
    assert_response :success, response.body
  end

  test "user should post deposit" do
    post user_deposit_url,
      params: { deposit: { amount: 150 } },
      headers: { Authorization: "Plain john@example.com"}, as: :json
    assert_response :success, response.body
  end

  test "user should post withdraw" do
    post user_withdraw_url,
      params: { withdraw: { amount: 150 } },
      headers: { Authorization: "Plain john@example.com"}, as: :json
    assert_response :success, response.body
  end

  test "user should post transfer" do
    john_wallet = wallets(:john)
    alice_wallet = wallets(:alice)

    post user_transfer_url,
      params: { transfer: { to_wallet_id: alice_wallet.id, amount: 150 } },
      headers: { Authorization: "Plain john@example.com"}, as: :json

    assert_response :success, response.body

    balance_after = Wallet.find(john_wallet.id).balance
    assert balance_after < john_wallet.balance, response.body
  end

  test "user should list their transactions" do
    get user_transactions_url, headers: { Authorization: "Plain john@example.com"}, as: :json
    assert_response :success, response.body
  end
end
