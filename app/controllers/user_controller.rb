class UserController < ApplicationController
  before_action :get_wallet
  before_action :authorize_user_only

  def wallet
    render json: @wallet, include: ['owner']
  end

  def deposit
    params.require(:deposit).permit(:amount)
    @wallet.balance += params[:deposit][:amount]
    @wallet.save
    render json: @wallet, include: ['owner']
  end

  def withdraw
    params.require(:withdraw).permit(:amount)
    @wallet.balance -= params[:withdraw][:amount]
    @wallet.save
    render json: @wallet, include: ['owner']
  end

  def transfer
    params.require(:transfer).permit(:to_wallet_id, :amount)
    to_wallet = Wallet.find(params[:transfer][:to_wallet_id])
    amount = params[:transfer][:amount]

    ActiveRecord::Base.transaction do
      trans = Transaction.create({
        to_wallet: to_wallet,
        from_wallet: @wallet,
        amount: amount
      })
      trans.save!

      @wallet.balance -= amount
      @wallet.save!

      to_wallet.balance += amount
      to_wallet.save!
    end

    render json: @wallet, include: ['owner']
  end

  def transactions
    @transcations = Transaction.where(to_wallet: @wallet).or(Transaction.where(from_wallet: @wallet)).order("created_at DESC")
    render json: @transactions
  end

  private
    def get_wallet
      @wallet = current_user.wallet
    end
end
