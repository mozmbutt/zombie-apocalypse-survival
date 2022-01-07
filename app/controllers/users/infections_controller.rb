class Users::InfectionsController < ApplicationController
  before_action :set_infection, only: %i[show edit update destroy]

  # GET /infections or /infections.json
  def index
    @infections = Infection.all
  end

  # GET /infections/1 or /infections/1.json
  def show; end

  # GET /infections/new
  def new
    @infection = Infection.new
  end

  # GET /infections/1/edit
  def edit; end

  # POST /infections or /infections.json
  def create
    @infection = Infection.create(infection_params)
    if @infection.save
      @user = User.find(@infection.reported_id)
      @report_count = Infection.where(reported_id: @user.id).count
      @user.update(infected: true) if @report_count >= 5
      redirect_to users_survivors_index_path, notice: 'Thank you for reporting survivor !'
    end
  end

  # PATCH/PUT /infections/1 or /infections/1.json
  def update
    respond_to do |format|
      if @infection.update(infection_params)
        format.html { redirect_to infection_url(@infection), notice: 'Infection was successfully updated.' }
        format.json { render :show, status: :ok, location: @infection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @infection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infections/1 or /infections/1.json
  def destroy
    @infection.destroy

    respond_to do |format|
      format.html { redirect_to infections_url, notice: 'Infection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_infection
    @infection = Infection.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def infection_params
    params.require(:infection).permit(:reporter_id, :reported_id)
  end
end
