# frozen_string_literal: true

module Users
  module SurvivorHelper
    # check if user didnt report already
    def can_report(reported_id)
      already_reported = Infection.exists?(reporter_id: current_user.id, reported_id: reported_id)
      if !already_reported && !current_user.infected
        true
      else
        false
      end
    end
  end
end
