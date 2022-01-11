# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  after_action :update_previous_location, only: [:create]
  before_action :check_infection, only: %i[new create]

  # show signed in survivor locations track back
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

  # update survivors previous location to false
  def update_previous_location
    current_user.locations.last(2).first.update(current: 'false')
  end

  # infected survivor can not change his location
  def check_infection
    redirect_to locations_path, alert: 'You are infected !' if current_user.infected
  end
end
