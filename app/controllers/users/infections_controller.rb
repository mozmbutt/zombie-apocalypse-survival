class Users::InfectionsController < ApplicationController
  after_action :check_or_mark_infected, only: [:create]

  # POST /infections or /infections.json
  def create
    @infection = Infection.new(infection_params)
    if @infection.save
      redirect_to users_survivors_index_path, notice: 'Thank you for reporting survivor !'
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def infection_params
    params.require(:infection).permit(:reporter_id, :reported_id)
  end

  def check_or_mark_infected
    @user = User.find(@infection.reported_id)
    @report_count = Infection.where(reported_id: @user.id).count
    @user.update(infected: true) if @report_count >= 5
  end
  
end
