# frozen_string_literal: true

require 'test_helper'

class TradeHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trade_history = trade_histories(:one)
  end

  test 'should get index' do
    get trade_histories_url
    assert_response :success
  end

  test 'should get new' do
    get new_trade_history_url
    assert_response :success
  end

  test 'should create trade_history' do
    assert_difference('TradeHistory.count') do
      post trade_histories_url, params: { trade_history: {} }
    end

    assert_redirected_to trade_history_url(TradeHistory.last)
  end

  test 'should show trade_history' do
    get trade_history_url(@trade_history)
    assert_response :success
  end

  test 'should get edit' do
    get edit_trade_history_url(@trade_history)
    assert_response :success
  end

  test 'should update trade_history' do
    patch trade_history_url(@trade_history), params: { trade_history: {} }
    assert_redirected_to trade_history_url(@trade_history)
  end

  test 'should destroy trade_history' do
    assert_difference('TradeHistory.count', -1) do
      delete trade_history_url(@trade_history)
    end

    assert_redirected_to trade_histories_url
  end
end
