class Trade < ApplicationRecord
  enum status: %i[pending accepted rejected canceled]

  belongs_to :base_trader, class_name: 'User', foreign_key: 'base_trader_id'
  belongs_to :trader, class_name: 'User', foreign_key: 'trader_id'

  has_many :trade_histories, dependent: :destroy

  accepts_nested_attributes_for :trade_histories
end
