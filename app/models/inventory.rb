# frozen_string_literal: true

class Inventory < ApplicationRecord
  validates :stock, presence: true

  belongs_to :user
  belongs_to :item
  scope :my_inventory, ->(current_user) { where(user_id: current_user.id).includes(:item) }

  ransacker :stock do
    Arel.sql("to_char(\"#{table_name}\".\"stock\", '99999')")
  end
end
