# frozen_string_literal: true

class Location < ApplicationRecord
  validates :lat, :lng, presence: true, numericality: { only_float: true }
  validate :check_infection

  belongs_to :user
  after_commit :update_previous_location, on: :create

  def update_previous_location
    user.locations.last(2).first.update(current: false)
  end

  def check_infection
    errors.add(:base, 'You are infected, Cant change your location !') if user.infected?
  end
end
