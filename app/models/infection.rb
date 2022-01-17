# frozen_string_literal: true

class Infection < ApplicationRecord
  belongs_to :reporter, class_name: 'User'
  belongs_to :report, class_name: 'User', foreign_key: 'reported_id', inverse_of: :reports

  after_save :check_or_mark_infected

  def check_or_mark_infected
    return unless report.reports.count >= 5

    report.update!(infected: true)
    report.base_traders.where(status: 'pending').update_all(status: 'canceled')
    report.traders.where(status: 'pending').update_all(status: 'canceled')
  end
end
