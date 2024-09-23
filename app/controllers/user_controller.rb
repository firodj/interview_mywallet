class UserController < ApplicationController
  before_action :get_wallet
  before_action :authorize_user_only

  def wallet
    render json: @wallet, include: ['owner']
  end

  def deposit
    params.require(:deposit).permit(:amount)
    amount = params[:deposit][:amount]
    if amount <= 0
      return render json: { message: "Illegal amount" }, status: :bad_request
    end

    processor = DepositProcessor.new(@wallet, amount)
    processor.run

    render json: processor.wallet, include: ['owner']
  end

  def withdraw
    params.require(:withdraw).permit(:amount)
    amount = params[:withdraw][:amount]
    if amount <= 0
      return render json: { message: "Illegal amount" }, status: :bad_request
    end

    processor = WithdrawProcessor.new(@wallet, amount)
    processor.run

    render json: processor.wallet, include: ['owner']
  end

  def transfer
    params.require(:transfer).permit(:to_wallet_id, :amount)
    to_wallet = Wallet.find(params[:transfer][:to_wallet_id])
    amount = params[:transfer][:amount]
    if amount <= 0
      return render json: { message: "Illegal amount" }, status: :bad_request
    end

    processor = TransferProcessor.new(@wallet, to_wallet, amount)
    processor.run

    render json: processor.from_wallet, include: ['owner']
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
