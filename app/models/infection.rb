# frozen_string_literal: true

class Infection < ApplicationRecord
  belongs_to :reporter, class_name: 'User'
  belongs_to :report, class_name: 'User', foreign_key: 'reported_id', inverse_of: :reports

  after_create :check_or_mark_infected

  def check_or_mark_infected
    report_count = report.reports.count
    report.update(infected: true) if report_count >= 5
  end
end
