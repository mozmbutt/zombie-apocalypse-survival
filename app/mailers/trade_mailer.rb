# frozen_string_literal: true

class TradeMailer < ApplicationMailer
  default from: 'moazzam.ali@devsinc.com'

  def trade_initiated_email
    @trade = params[:trade]
    filter_trade_histories
    mail(
      to: @trade.base_trader.email,
      cc: 'mozmbutt8@gmail.com',
      subject: 'Trade request successfully sent'
    )
  end

  def filter_trade_histories
    histories = @trade.trade_histories
    @base_trade_histories = histories.offered_items(@trade.base_trader)
    @trade_histories = histories.exchange_with_items(@trade.base_trader)
  end

  def trade_status_email
    @trade = params[:trade]
    mail(
      to: @trade.base_trader.email,
      cc: 'mozmbutt8@gmail.com',
      subject: 'Trade status update'
    )
  end
end
