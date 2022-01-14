# frozen_string_literal: true

class Inventory < ApplicationRecord
  validates :stock, presence: true, numericality: { only_float: true }

  belongs_to :user
  belongs_to :item
  belongs_to :trade_history, class_name: 'TradeHistory',
                             foreign_key: :item_id,
                             optional: true,
                             inverse_of: :inventory

  ransacker :stock do
    Arel.sql("to_char(\"#{table_name}\".\"stock\", '99999')")
  end

  def self.items_average
    items_average_report = []
    investery_items = Inventory.joins(:item)
    avg_items = investery_items.group(:item_id).average(:stock)
    avg_names = investery_items.pluck(:item_id, :name).uniq

    avg_names.each do |item_id, item_name|
      avg_items[item_id]
      items_average_report.push(item_name => avg_items[item_id].to_i)
    end
    items_average_report
  end
end
