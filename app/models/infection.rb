class Infection < ApplicationRecord
  belongs_to :reporter, class_name: 'User', foreign_key: 'reporter_id'
  belongs_to :report, class_name: 'User', foreign_key: 'reported_id'
end
