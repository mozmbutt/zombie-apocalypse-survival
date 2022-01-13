# frozen_string_literal: true

class Trade < ApplicationRecord
  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 }

  belongs_to :base_trader, class_name: 'User'
  belongs_to :trader, class_name: 'User'

  has_many :trade_histories, dependent: :destroy

  accepts_nested_attributes_for :trade_histories, reject_if: :reject_trade_item

  def reject_trade_item(attributes)
    attributes['quantity'].to_i.zero? || attributes['quantity'].blank?
  end

  def user_trade_histories(user_id)
    trade_histories.where(user_id: user_id).includes(:inventory).where(inventory: { user_id: user_id })
  end

  def user_trade_histories_credit(user_id)
    trade_histories.where(user_id: user_id).includes(:inventory).where.not(inventory: { user_id: user_id })
  end

  def base_trader_histories
    user_trade_histories(base_trader_id)
  end

  def trader_histories
    user_trade_histories(trader_id)
  end

  def base_trader_histories_credit
    user_trade_histories_credit(base_trader_id)
  end

  def trader_histories_credit
    user_trade_histories_credit(trader_id)
  end

  def trading_transection
    @base_trader_histories = base_trader_histories
    @trader_histories = trader_histories
    @base_trader_histories_credit = base_trader_histories_credit
    @trader_histories_credit = trader_histories_credit

    Trade.transaction do
      debit_stock(@base_trader_histories) # minus stock from base_trader
      debit_stock(@trader_histories) # minus stock from trader

      credit_stock(@base_trader_histories_credit) # add stock to trader
      credit_stock(@trader_histories_credit) # add stock to base_tradertrader
    end
  end

  # Detuct stock from survivor's inventory
  def debit_stock(histories)
    histories.each do |t_history|
      inventory_item = t_history.inventory
      new_stock = inventory_item.stock - t_history.quantity
      inventory_item.update(stock: new_stock)
    end
  end

  # Add stock to survivor's inventory
  def credit_stock(histories)
    histories.each do |t_history|
      inventory_item = t_history.inventory
      new_stock = inventory_item.stock + t_history.quantity
      inventory_item.update(stock: new_stock)
    end
  end
end
