# frozen_string_literal: true

class Location < ApplicationRecord
  validates :lat, :lng, presence: true
  belongs_to :user
end
