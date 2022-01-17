# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :points, null: false

      t.timestamps
    end
  end
end
