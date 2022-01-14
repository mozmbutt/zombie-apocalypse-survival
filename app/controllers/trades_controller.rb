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
    @trader = User.find(params[:trader_id])
    redirect_to users_survivors_index_path, alert: 'Infected Survivor can not trade.' if @trader.infected
    @base_trader_inventories = current_user.inventories
    @trader_inventories = Inventory.where(user_id: params[:trader_id])
    @trade = Trade.new
  end

  def create
    @trade = Trade.new(trade_params)
    if @trade.save!
      redirect_to trades_path, notice: 'Trade Initiated.'
    else
      redirect_to users_survivors_index_path, alert: 'Trade not initiated.'
    end
  end

  def update
    status = params[:status]
    @trade.trading_transection if status == 'accepted'
    respond_to do |format|
      if @trade.update(status: status)
        format.html { redirect_to trades_url, notice: "Trade is successfully #{status}." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trade
    @trade = Trade.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trade_params
    params.require(:trade).permit(:id, :status, :base_trader_id, :trader_id,
                                  trade_histories_attributes: %i[quantity item_id user_id])
  end
end
