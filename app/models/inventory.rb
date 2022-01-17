# frozen_string_literal: true

class Inventory < ApplicationRecord
  validates :stock, presence: true, numericality: { only_float: true }
  validates :item_id, uniqueness: { scope: %i[item_id user_id] }

  belongs_to :user
  belongs_to :item
  belongs_to :trade_history, class_name: 'TradeHistory',
                             foreign_key: :item_id,
                             primary_key: :item_id,
                             optional: true,
                             inverse_of: :inventory

  ransacker :stock do
    Arel.sql("to_char(\"#{table_name}\".\"stock\", '99999')")
  end

  def self.items_average
    investery_items = Inventory.joins(:item)
    investery_items.group(:name).average(:stock)
  end
end
