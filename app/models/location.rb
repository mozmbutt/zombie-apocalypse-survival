# frozen_string_literal: true

class Location < ApplicationRecord
  validates :lat, :lng, presence: true, numericality: { only_float: true }

  belongs_to :user
  after_commit :update_previous_location, on: :create

  def update_previous_location
    user_last_location = user.locations.second_to_last
    user_last_location.update!(current: false) unless user_last_location&.nil?
  end
end
