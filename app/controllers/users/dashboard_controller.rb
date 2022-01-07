class Users::DashboardController < ApplicationController
  def index
    @inventories = Inventory.my_inventory(current_user)
    @reports = current_user.reports.count
  end
end
