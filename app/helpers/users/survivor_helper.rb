module Users::SurvivorHelper
  # check if user didnt report already
  def can_report(reported_id)
    check = Infection.where(reporter_id: current_user.id, reported_id: reported_id)
    if check.blank? && !current_user.infected
      true
    else
      false
    end
  end
end
