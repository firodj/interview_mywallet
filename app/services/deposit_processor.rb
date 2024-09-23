class DepositProcessor
  attr_reader :wallet

  def initialize(wallet, amount)
    @wallet = wallet
    @amount = amount
  end

  def run
    ActiveRecord::Base.transaction do
      trans = Transaction.create({
        to_wallet: @wallet,
        from_wallet: nil,
        amount: @amount
      })
      trans.save!

      @wallet.balance += @amount
      @wallet.save!
    end
  end
end