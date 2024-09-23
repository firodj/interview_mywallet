class WithdrawProcessor
  attr_reader :wallet

  def initialize(wallet, amount)
    @wallet = wallet
    @amount = amount
  end

  def run
    ActiveRecord::Base.transaction do
      raise CustomErrors::InsufficientBalance if @amount > @wallet.balance

      trans = Transaction.create({
        from_wallet: @wallet,
        to_wallet: nil,
        amount: @amount
      })
      trans.save!

      @wallet.balance -= @amount
      @wallet.save!
    end
  end
end