# frozen_string_literal: true

class TradeHistoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    trade_history = TradeHistory.where(trade_id: params[:trade_id])
    @base_trade_histories = trade_history.offered_items(current_user)
    @trade_histories = trade_history.exchange_with_items(current_user)
  end
end
