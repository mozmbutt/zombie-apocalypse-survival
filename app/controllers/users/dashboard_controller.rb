# frozen_string_literal: true

module Users
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :check_role, only: [:reports]

    def index
      @inventories = current_user.inventories
      @reports = current_user.reports.count
    end

    def reports
      @infected = User.infected_percentage
      @non_infected = User.non_infected_percentage
      @items_average_report = Inventory.items_average
      @infection_point_lost = User.infected(true).includes(:inventories).sum(:stock)
      @total_survivors = User.survivor.count
    end

    private

    def check_role
      return unless current_user.survivor?

      redirect_to users_dashboard_index_path,
                  alert: 'You are notauthenticated for view reports!'
    end
  end
end
