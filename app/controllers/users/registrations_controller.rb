# frozen_string_literal: true

# User is our app user, that could be survivor or admin by role
module Users
  class RegistrationsController < Devise::RegistrationsController
    after_action :welcome_email, only: [:create]
    def new
      @items ||= Item.all
      super
    end

    def create
      @items ||= Item.all
      super
    end

    private

    def welcome_email
      UserMailer.with(user: @user).welcome_email.deliver_later
    end
  end
end
