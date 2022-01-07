class Users::SurvivorsController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    # @people = @q.result.includes(:articles).page(params[:page])
    @survivors = @q.result(distinct: true).where(role: 'survivor').where.not(id: current_user.id).includes(:inventories).joins(:inventories)
  end
end
