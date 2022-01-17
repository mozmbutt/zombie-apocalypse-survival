# frozen_string_literal: true

class Location < ApplicationRecord
  validates :lat, :lng, presence: true, numericality: { only_float: true }

  belongs_to :user
  before_create :update_previous_location

  def update_previous_location
    user_last_location = user.locations.last
    user_last_location.update!(current: false) unless user_last_location&.nil?
  end
end
