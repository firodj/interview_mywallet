require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "save transaction without both wallets will fail" do
    trans = Transaction.new
    assert_not trans.save
  end

  test "save transaction as deposit will success" do
    trans = Transaction.new
    trans.to_wallet = wallets(:john)
    trans.amount = 100

    assert trans.save
  end

  test "save transaction as withdraw will success" do
    trans = Transaction.new
    trans.from_wallet = wallets(:john)
    trans.amount = 100

    assert trans.save
  end

  test "save transaction as transfer will success" do
    trans = Transaction.new
    trans.from_wallet = wallets(:john)
    trans.to_wallet = wallets(:y2b)
    trans.amount = 100

    assert trans.save
  end

  test "save transaction without amount will failed" do
    trans = Transaction.new
    trans.from_wallet = wallets(:john)
    trans.to_wallet = wallets(:y2b)
    trans.amount = 0

    assert_not trans.save
  end

  test "save transaction within same wallet will failed" do
    trans = Transaction.new
    trans.from_wallet = wallets(:john)
    trans.to_wallet = wallets(:john)
    trans.amount = 100

    assert_not trans.save
  end

  test "update existing transaction from wallet will failed" do
    trans = transactions(:one)
    trans.from_wallet = wallets(:alice)
    assert_not trans.save
  end

  test "update existing transaction to wallet will failed" do
    trans = transactions(:one)
    trans.to_wallet = wallets(:alice)
    assert_not trans.save
  end

  test "update existing transaction amount will failed" do
    trans = transactions(:one)
    trans.amount = 1.11
    assert_not trans.save
  end
end
