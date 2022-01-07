class Item < ApplicationRecord
  has_many :invetories
  has_many :users, through: :inventories
end
