# frozen_string_literal: true

class Trade < ApplicationRecord
  # before_create :confirm_trade
  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 }

  belongs_to :base_trader, class_name: 'User'
  belongs_to :trader, class_name: 'User'

  has_many :trade_histories, dependent: :destroy

  accepts_nested_attributes_for :trade_histories

  def user_trade_histories(user_id)
    trade_histories.where(user_id: user_id)
  end

  def base_trader_histories
    user_trade_histories(base_trader_id)
  end

  def trader_histories
    user_trade_histories(trader_id)
  end

  def base_trader_inventory
    base_trader.inventories
  end

  def trader_inventory
    trader.inventories
  end

  def trading_transection
    @base_trader_histories = base_trader_histories
    @trader_histories = trader_histories
    @base_trader_inventories = base_trader_inventory
    @trader_inventories = trader_inventory

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
end
