class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :item
  scope :my_inventory, ->(current_user) { where(user_id: current_user.id).includes(:item) }
end
