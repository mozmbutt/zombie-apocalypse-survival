class TradeHistoriesController < ApplicationController
  before_action :set_trade_history, only: %i[show edit update destroy]
  before_action :authenticate_user!
  
  # GET /trade_histories or /trade_histories.json
  def index
    @base_trade_histories = TradeHistory.all.where(trade_id: params[:trade_id])
                                        .where(user_id: current_user.id)
    @trade_histories = TradeHistory.all.where(trade_id: params[:trade_id])
                                   .where.not(user_id: current_user.id)
  end

  # GET /trade_histories/1 or /trade_histories/1.json
  def show; end

  # GET /trade_histories/new
  def new
    @trade_history = TradeHistory.new
  end

  # GET /trade_histories/1/edit
  def edit; end

  # POST /trade_histories or /trade_histories.json
  def create
    @trade_history = TradeHistory.new(trade_history_params)

    respond_to do |format|
      if @trade_history.save
        format.html { redirect_to trade_history_url(@trade_history), notice: 'Trade history was successfully created.' }
        format.json { render :show, status: :created, location: @trade_history }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trade_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_histories/1 or /trade_histories/1.json
  def update
    respond_to do |format|
      if @trade_history.update(trade_history_params)
        format.html { redirect_to trade_history_url(@trade_history), notice: 'Trade history was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade_history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trade_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_histories/1 or /trade_histories/1.json
  def destroy
    @trade_history.destroy

    respond_to do |format|
      format.html { redirect_to trade_histories_url, notice: 'Trade history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trade_history
    @trade_history = TradeHistory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trade_history_params
    params.fetch(:trade_history, {})
  end
end
