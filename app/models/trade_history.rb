class TradeHistory < ApplicationRecord
  belongs_to :trade
  belongs_to :item
  belongs_to :user

  scope :offered_items, ->(current_user) { where(user_id: current_user.id) }
  scope :exchange_with_items, ->(current_user) { where.not(user_id: current_user.id) }
end
