# frozen_string_literal: true

class TradeHistory < ApplicationRecord
  belongs_to :trade
  belongs_to :item
  belongs_to :user

  scope :offered_items, ->(user) { where(user_id: user.id) }
  scope :exchange_with_items, ->(user) { where.not(user_id: user.id) }
end
