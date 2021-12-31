class InfectionsController < ApplicationController
  before_action :set_infection, only: %i[ show edit update destroy ]

  # GET /infections or /infections.json
  def index
    @infections = Infection.all
  end

  # GET /infections/1 or /infections/1.json
  def show
  end

  # GET /infections/new
  def new
    @infection = Infection.new
  end

  # GET /infections/1/edit
  def edit
  end

  # POST /infections or /infections.json
  def create
    @infection = Infection.new(infection_params)

    respond_to do |format|
      if @infection.save
        format.html { redirect_to infection_url(@infection), notice: "Infection was successfully created." }
        format.json { render :show, status: :created, location: @infection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @infection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infections/1 or /infections/1.json
  def update
    respond_to do |format|
      if @infection.update(infection_params)
        format.html { redirect_to infection_url(@infection), notice: "Infection was successfully updated." }
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
      format.html { redirect_to infections_url, notice: "Infection was successfully destroyed." }
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
      params.fetch(:infection, {})
    end
end
