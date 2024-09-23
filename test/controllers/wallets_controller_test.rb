require "test_helper"

class WalletsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wallet = wallets(:john)
  end

  test "system should list all wallets" do
    get wallets_url, headers: { Authorization: "Plain system" }, as: :json
    assert_response :success
  end

  test "system should show wallet" do
    get wallet_url(@wallet), headers: { Authorization: "Plain system" }, as: :json
    assert_response :success
  end
end
