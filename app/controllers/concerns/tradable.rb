# frozen_string_literal: true

# ./app/controllers/concerns/tradable.rb
# This module have all logic related to trading between survivors
module Tradable
  extend ActiveSupport::Concern

  # call function to make sure both sides of trade has equal points
  def confirm_trade
    load_trader_items
    base_trader_points = calculate_trade_points(@base_trader_items)
    trader_points = calculate_trade_points(@trader_items)
    return if trade_pre_conditions(base_trader_points, trader_points)

    redirect_to new_trade_url(base_trader_id: params[:trade][:base_trader_id].to_i,
                              trader_id: params[:trade][:trader_id].to_i),
                alert: 'Please check you trading items points (should be equal and more than 0)'
  end

  def trade_pre_conditions(base_trader_points, trader_points)
    !base_trader_points.zero? && !trader_points.zero? && (trader_points == base_trader_points)
  end

  def calculate_trade_points(trader_items)
    trader_points = 0
    trader_items.each do |item|
      trader_points += item[:item_points].to_i * item[:quantity].to_i
    end
    trader_points
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
