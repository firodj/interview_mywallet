class TransferProcessor
  attr_reader :from_wallet
  attr_reader :to_wallet

  def initialize(from_wallet, to_wallet, amount)
    @from_wallet = from_wallet
    @to_wallet = to_wallet
    @amount = amount
  end

  def run
    ActiveRecord::Base.transaction do
      raise CustomErrors::InsufficientBalance if @amount > @from_wallet.balance

      trans = Transaction.create({
        from_wallet: @from_wallet,
        to_wallet: @to_wallet,
        amount: @amount
      })
      trans.save!

      @from_wallet.balance -= @amount
      @from_wallet.save!

      @to_wallet.balance += @amount
      @to_wallet.save!
    end
  end
end