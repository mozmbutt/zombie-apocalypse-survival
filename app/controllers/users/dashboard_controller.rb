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
      @infected, @non_infected = infection_percent
      read_items_average_report
      @infection_point_lost = User.where(infected: true).includes(:inventories).sum(:stock)
      @total_survivors = User.survivors_count
    end

    private

    def check_role
      unless current_user.admin?
        redirect_to users_dashboard_index_path,
                    alert: 'You are notauthenticated for view reports!'
      end
    end

    def infection_percent
      total_survivors = User.survivors_count
      infected_survivors = User.infected_survivors_count
      non_infected_survivors = User.non_infected_survivors_count
      infected = (infected_survivors * 100) / total_survivors
      non_infected = (non_infected_survivors * 100) / total_survivors
      [infected, non_infected]
    end

    def read_items_average_report
      @items_average_report = []
      avg_items = Inventory.group(:item_id).average(:stock)
      avg_items.each do |item_id, avg_stock|
        item = Item.find(item_id)
        @items_average_report.push(item.name => avg_stock.to_i)
      end
    end
  end
end
