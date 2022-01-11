# frozen_string_literal: true

class Trade < ApplicationRecord
  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 }

  belongs_to :base_trader, class_name: 'User'
  belongs_to :trader, class_name: 'User'

  has_many :trade_histories, dependent: :destroy

  accepts_nested_attributes_for :trade_histories
end
