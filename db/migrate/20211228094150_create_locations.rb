# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :lat, null: false, default: 0
      t.decimal :lng, null: false, default: 0
      t.boolean :current, null: false, default: true

      t.timestamps
    end
  end
end
