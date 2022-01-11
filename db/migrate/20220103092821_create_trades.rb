# frozen_string_literal: true

class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.references :base_trader, references: :users, foreign_key: { to_table: :users }
      t.references :trader, references: :users, foreign_key: { to_table: :users }
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
