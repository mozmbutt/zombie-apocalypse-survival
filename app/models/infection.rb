# frozen_string_literal: true

class Infection < ApplicationRecord
  belongs_to :reporter, class_name: 'User'
  belongs_to :report, class_name: 'User', foreign_key: 'reported_id', inverse_of: :reports
end
