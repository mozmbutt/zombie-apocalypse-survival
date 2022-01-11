# frozen_string_literal: true

class Item < ApplicationRecord
  validates :name, :points, presence: true

  has_many :invetories, dependent: :destroy
  has_many :users, through: :inventories
  has_many :trade_histories, dependent: :destroy
end
