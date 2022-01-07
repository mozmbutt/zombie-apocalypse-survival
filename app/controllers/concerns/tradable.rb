# ./app/controllers/concerns/tradable.rb
# This module have all logic related to trading between survivors
module Tradable
  extend ActiveSupport::Concern
  
  # Trading transection to exchange inventory stock between surviviors
  def trading_transection
    @trade = Trade.find(params[:id])
    load_history
    load_inventory
    Trade.transaction do
      debit_stock(@base_trader_histories, @base_trader_inventories) # minus stock from base_trader
      debit_stock(@trader_histories, @trader_inventories) # minus stock from trader

      credit_stock(@base_trader_histories, @trader_inventories) # add stock to base_trader
      credit_stock(@trader_histories, @base_trader_inventories) # add stock to trader
    end
  end

  # Detuct stock from survivor's inventory
  def debit_stock(histories, inventories)
    histories.each do |t_history|
      inventory_item = inventories.find_by(item_id: t_history[:item_id])
      new_stock = inventory_item.stock - t_history[:quantity]
      inventory_item.update(stock: new_stock)
    end
  end

  # Add stock to survivor's inventory
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

  # call function to make sure both sides of trade has equal points
  def confirm_trade
    load_trader_items
    base_trader_points = calculate_trade_points(@base_trader_items)
    trader_points = calculate_trade_points(@trader_items)
    if (base_trader_points == 0) || (trader_points == 0) || (trader_points != base_trader_points)
      redirect_to new_trade_url(base_trader_id: params[:trade][:base_trader_id].to_i,
                                trader_id: params[:trade][:trader_id].to_i),
                  alert: 'Please check you trading items points (should be equal and more than 0)'
    end
  end

  def calculate_trade_points(trader_items)
    trader_points = 0
    trader_items.each do |item|
      trader_points += Item.find(item[:item_id])[:points].to_i * item[:quantity].to_i
    end
    return trader_points
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
