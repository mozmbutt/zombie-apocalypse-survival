module Users::SurvivorHelper
  def can_report(reported_id)
    check = Infection.where(reporter_id: current_user.id).and(Infection.where(reported_id: reported_id))
    if check.blank? && !current_user.infected
      true
    else
      false
    end
  end
end
