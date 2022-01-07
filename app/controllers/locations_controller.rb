class LocationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_location, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :update_previous_location, only: %i[create]
  before_action :check_infection, only: %i[new create]

  # GET /locations or /locations.json
  def index
    @locations = Location.all.where(user_id: current_user.id)
  end

  # GET /locations/1 or /locations/1.json
  def show; end

  # GET /locations/new
  def new
    @location = Location.new(user_id: current_user.id)
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to location_url(@location), notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location), notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_previous_location
    current_user.locations.last.update(current: 'false')
  end

  def check_infection
    if current_user.infected
      redirect_to locations_path
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
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
end
