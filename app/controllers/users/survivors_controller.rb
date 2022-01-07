class Users::SurvivorsController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @survivors = @q.result(distinct: true).role_survivor.except_survivor(current_user).joins(:inventories)
  end
end
