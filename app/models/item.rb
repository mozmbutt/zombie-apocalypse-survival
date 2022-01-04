class Item < ApplicationRecord
  validates_presence_of :name, :points
  
  has_many :invetories
  has_many :users, through: :inventories
  has_many :trade_histories
end
