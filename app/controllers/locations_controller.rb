class LocationsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :update_previous_location, only: [:create]
  before_action :check_infection, only: %i[new create]

  # GET /locations or /locations.json
  def index
    @locations = current_user.locations
  end

  # GET /locations/new
  def new
    @location = Location.new(user_id: current_user.id)
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_path, notice: 'Location was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:user_id, :lat, :lng, :current)
  end

  def update_previous_location
    current_user.locations.last.update(current: 'false')
  end

  def check_infection
    if current_user.infected
      redirect_to locations_path, alert: 'You are infected !'
    end
  end
end
