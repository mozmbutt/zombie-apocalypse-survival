# frozen_string_literal: true

require 'application_system_test_case'

class TradeHistoriesTest < ApplicationSystemTestCase
  setup do
    @trade_history = trade_histories(:one)
  end

  test 'visiting the index' do
    visit trade_histories_url
    assert_selector 'h1', text: 'Trade Histories'
  end

  test 'creating a Trade history' do
    visit trade_histories_url
    click_on 'New Trade History'

    click_on 'Create Trade history'

    assert_text 'Trade history was successfully created'
    click_on 'Back'
  end

  test 'updating a Trade history' do
    visit trade_histories_url
    click_on 'Edit', match: :first

    click_on 'Update Trade history'

    assert_text 'Trade history was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Trade history' do
    visit trade_histories_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Trade history was successfully destroyed'
  end
end
