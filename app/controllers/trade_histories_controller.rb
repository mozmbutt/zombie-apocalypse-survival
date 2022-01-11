# frozen_string_literal: true

class TradeHistoriesController < ApplicationController
  # before_action :set_trade_history, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    trade_history = TradeHistory.where(trade_id: params[:trade_id])
    @base_trade_histories = trade_history.offered_items(current_user)
    @trade_histories = trade_history.exchange_with_items(current_user)
  end
end
