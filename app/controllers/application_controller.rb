# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_perameters, if: :devise_controller?

  protected

  def configure_permitted_perameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :gender, :email, :photo,
                                                       :password, :password_confirmation,
                                                       { locations_attributes: %i[lat lng],
                                                         inventories_attributes: %i[user_id item_id stock] }])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[name age gender email photo
                                                                password password_confirmation current_password])
  end

  def after_sign_in_path_for(_resource)
    users_dashboard_index_path
  end

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to users_dashboard_index_path, alert: 'ouch! Its seems like you have no rights!'
  end
end
