# frozen_string_literal: true

module Users
  class InfectionsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    def create
      @infection = Infection.new(infection_params)
      redirect_to users_survivors_index_path, notice: 'Thank you for reporting survivor !' if @infection.save
    end

    private

    def infection_params
      params.require(:infection).permit(:reporter_id, :reported_id)
    end
  end
end
