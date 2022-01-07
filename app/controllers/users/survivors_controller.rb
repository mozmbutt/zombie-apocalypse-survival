class Users::SurvivorsController < ApplicationController
  def index
    @survivors = User.all.where(role: 'survivor').where.not(id: current_user.id)
  end
end
