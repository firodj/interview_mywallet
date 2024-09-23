class TransactionsController < ApplicationController
  before_action :authorize_admin_only
  before_action :set_transaction, only: %i[ show ]

  # GET /transactions
  def index
    @transactions = Transaction.all

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:from_wallet_id, :to_wallet_id, :amount)
    end
end
