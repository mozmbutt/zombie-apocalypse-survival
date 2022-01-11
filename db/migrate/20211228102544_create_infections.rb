# frozen_string_literal: true

class CreateInfections < ActiveRecord::Migration[6.1]
  def change
    create_table :infections do |t|
      t.references :reporter, references: :users, foreign_key: { to_table: :users }
      t.references :reported, references: :users, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
