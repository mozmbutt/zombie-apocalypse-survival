# frozen_string_literal: true

class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.references :user, null: false
      t.references :item, null: false
      t.integer :stock, null: false
      t.index %w[user_id item_id], name: 'index_apps_on_user_id_and_item_id', unique: true

      t.timestamps
    end
  end
end
