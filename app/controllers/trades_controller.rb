class TradesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_trade, only: %i[show edit update destroy]
  before_action :confirm_trade, only: [:create]

  # GET /trades or /trades.json
  def index
    @base_trades = Trade.all.where(base_trader_id: current_user.id)
    @trades = Trade.all.where(trader_id: current_user.id)
  end

  # GET /trades/1 or /trades/1.json
  def show; end

  # GET /trades/new
  def new
    @base_trader_inventories = Inventory.where(user_id: params[:base_trader_id])
    @trader_inventories = Inventory.where(user_id: params[:trader_id])
    @trader = User.find(params[:trader_id])
    @trade = Trade.new
  end

  # GET /trades/1/edit
  def edit; end

  # POST /trades or /trades.json
  def create
    @trade = Trade.create(trade_params)
    if @trade.save!
      redirect_to trades_path
    else
      redirect_to users_survivors_index_path, notice: 'Trade not initiated.'
    end
  end

  # PATCH/PUT /trades/1 or /trades/1.json
  def update
    status = params[:status]
    trading_transection if status == 'accepted'
    @trade.update(status: status)
    respond_to do |format|
      format.html { redirect_to trades_url, notice: "Trade is successfully #{status}." }
      format.json { head :no_content }
    end
  end

  # DELETE /trades/1 or /trades/1.json
  def destroy
    @trade.destroy

    respond_to do |format|
      format.html { redirect_to trades_url, notice: "Trade is successfully #{status}." }
      format.json { head :no_content }
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

  def trading_transection
    @trade = Trade.find(params[:id])
    load_history
    load_inventory
    ActiveRecord::Base.transaction do
      debit_stock(@base_trader_histories, @base_trader_inventories) # minus stock from base_trader
      debit_stock(@trader_histories, @trader_inventories) # minus stock from trader

      credit_stock(@base_trader_histories, @trader_inventories) # add stock to base_trader
      credit_stock(@trader_histories, @base_trader_inventories) # add stock to trader
    end
  end

  def debit_stock(histories, inventories)
    histories.each do |t_history|
      inventory_item = inventories.find_by(item_id: t_history[:item_id])
      new_stock = inventory_item.stock - t_history[:quantity]
      inventory_item.update(stock: new_stock)
    end
  end

  def credit_stock(histories, inventories)
    histories.each do |t_history|
      inventory_item = inventories.find_by(item_id: t_history[:item_id])
      new_stock = inventory_item.stock + t_history[:quantity]
      inventory_item.update(stock: new_stock)
    end
  end

  def load_history
    @base_trader_histories = @trade.trade_histories.where(user_id: @trade[:base_trader_id])
    @trader_histories = @trade.trade_histories.where(user_id: @trade[:trader_id])
  end

  def load_inventory
    @base_trader_inventories = Inventory.where(user_id: @trade[:base_trader_id])
    @trader_inventories = Inventory.where(user_id: @trade[:trader_id])
  end

  def confirm_trade
    load_trader_items
    base_trader_points = calculate_trade_points(@base_trader_items)
    trader_points = calculate_trade_points(@trader_items)

    if (base_trader_points == 0) || (trader_points == 0) || (trader_points != base_trader_points)
      redirect_to new_trade_url(base_trader_id: params[:trade][:base_trader_id].to_i,
                                trader_id: params[:trade][:trader_id].to_i),
                  alert: 'Trading Items cost different points'
    end
  end

  def calculate_trade_points(trader_items)
    trader_points = 0
    trader_items.each do |item|
      trader_points += Item.find(item[:item_id])[:points].to_i * item[:quantity].to_i
    end
  end

  def load_trader_items
    @base_trader_items = []
    @trader_items = []

    params[:trade][:trade_histories_attributes].each do |_index, t_history|
      if t_history[:user_id].to_i == current_user.id
        @base_trader_items.push(t_history)
      else
        @trader_items.push(t_history)
      end
    end
  end
end
