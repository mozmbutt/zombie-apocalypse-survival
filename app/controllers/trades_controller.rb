# frozen_string_literal: true

class TradesController < ApplicationController
  include Tradable
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_trade, only: [:update]
  before_action :confirm_trade, only: [:create]

  def index
    @base_trades = Trade.where(base_trader_id: current_user.id)
    @trades = Trade.where(trader_id: current_user.id)
  end

  def new
    @base_trader_inventories = current_user.inventories
    @trader_inventories = Inventory.where(user_id: params[:trader_id])
    @trader = User.find(params[:trader_id])
    @trade = Trade.new
  end

  def create
    @trade = Trade.create(trade_params)
    if @trade.save!
      redirect_to trades_path, notice: 'Trade Initiated.'
    else
      redirect_to users_survivors_index_path, alert: 'Trade not initiated.'
    end
  end

  def update
    status = params[:status]
    trading_transection if status == 'accepted'
    @trade.update(status: status)
    respond_to do |format|
      format.html { redirect_to trades_url, notice: "Trade is successfully #{status}." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trade
    @trade = Trade.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trade_params
    params.require(:trade).permit(:id, :status, :base_trader_id, :trader_id, trade_histories_attributes: {})
  end
end
