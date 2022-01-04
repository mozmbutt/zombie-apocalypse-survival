class Location < ApplicationRecord
  validates_presence_of :lat, :lng
  belongs_to :user
end
