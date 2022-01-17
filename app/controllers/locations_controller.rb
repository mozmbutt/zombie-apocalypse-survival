# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :check_infection, only: %i[new create]

  def index
    @locations = current_user.locations
  end

  def new
    @location = current_user.locations.new
  end

  def create
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_path, notice: 'Location was successfully changed.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:user_id, :lat, :lng, :current)
  end

  def check_infection
    return unless current_user.infected?

    respond_to do |format|
      format.html { redirect_to locations_path, notice: 'You are infected, Cant change your location !' }
    end
  end
end
