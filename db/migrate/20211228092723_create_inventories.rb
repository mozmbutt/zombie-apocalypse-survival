class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.references :user
      t.references :item
      t.integer :stock

      t.timestamps
    end
  end
end
