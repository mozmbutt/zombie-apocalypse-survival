# frozen_string_literal: true

class CreateTradeHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :trade_histories do |t|
      t.references :trade, null: false
      t.references :item, null: false
      t.references :user, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
