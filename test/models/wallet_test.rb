require "test_helper"

class WalletTest < ActiveSupport::TestCase
  test "create wallet without owner will fail" do
    wallet = Wallet.new
    assert_not wallet.save
  end

  test "create wallet with user as an owner will success" do
    wallet = Wallet.new
    wallet.owner = users(:alice)
    assert wallet.save
  end

  test "create wallet with team as an owner will success" do
    wallet = Wallet.new
    wallet.owner = teams(:yellow)
    assert wallet.save
  end

  test "create wallet with stock as an owner will success" do
    wallet = Wallet.new
    wallet.owner = stocks(:y9s)
    assert wallet.save
  end

  test "update wallet balance will success" do
    wallet = wallets(:john)
    wallet.balance += 100
    assert wallet.save
  end

  test "update wallet owner will failed" do
    wallet = wallets(:john)
    assert wallet.owner == users(:john)
    wallet.owner = teams(:blue)
    assert_not wallet.save
  end
end
