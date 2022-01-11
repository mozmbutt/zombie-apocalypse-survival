# frozen_string_literal: true

# User is our app user, that could be survivor or admin by role
module Users
  class RegistrationsController < Devise::RegistrationsController
    def new
      @items ||= Item.all
      super
    end

    def create
      @items ||= Item.all
      super
    end
  end
end
