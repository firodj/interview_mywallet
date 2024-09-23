class WalletsController < ApplicationController
  before_action :authorize_admin_only
  before_action :set_wallet, only: %i[ show deposit withdraw ]

  # GET /api/v1/wallets
  # This is currently only for system
  def index
    @wallets = Wallet.all
    render json: @wallets, include: ['owner']
  end

  # GET /api/v1/wallets/1
  def show
    render json: @wallet, include: ['owner']
  end

  # POST /api/v1/wallets/1/deposit
  def deposit
    params.require(:deposit).permit(:amount)
    amount = params[:deposit][:amount]
    if amount <= 0
      return render json: { message: "Illegal amount" }, status: :bad_request
    end

    if @wallet.owner_type != 'Stock'
      return render json: { message: "invalid Stock wallet" }, status: :bad_request
    end

    processor = DepositProcessor.new(@wallet, amount)
    processor.run

    render json: processor.wallet, include: ['owner']
  end

  # POST /api/v1/wallets/1/withdraw
  def withdraw
    params.require(:withdraw).permit(:amount)
    amount = params[:withdraw][:amount]
    if amount <= 0
      return render json: { message: "Illegal amount" }, status: :bad_request
    end

    if @wallet.owner_type != 'Stock'
      return render json: { message: "invalid Stock wallet" }, status: :bad_request
    end

    processor = WithdrawProcessor.new(@wallet, amount)
    processor.run

    render json: processor.wallet, include: ['owner']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id] || params[:wallet_id])
    end
end
