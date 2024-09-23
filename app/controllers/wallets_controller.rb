class WalletsController < ApplicationController
  before_action :authorize_admin_only
  before_action :set_wallet, only: %i[ show ]

  # GET /wallets
  # This is currently only for system
  def index
    @wallets = Wallet.all
    render json: @wallets, include: ['owner']
  end

  # GET /wallets/1
  def show
    render json: @wallet, include: ['owner']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end
end
