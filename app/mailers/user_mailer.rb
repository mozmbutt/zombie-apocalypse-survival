# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'moazzam.ali@devsinc.com'

  def welcome_email
    @user = params[:user]
    @inventories = @user.inventories
    mail(
      to: @user.email,
      cc: 'mozmbutt8@gmail.com',
      subject: 'Welcome to Zombie Apocalypse Survival'
    )
  end
end
