# frozen_string_literal: true

class CreateTradeHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :trade_histories do |t|
      t.references :trade
      t.references :item
      t.references :user
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
