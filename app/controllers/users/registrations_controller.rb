# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_perameters, only: %i[create update]

  # GET /resource/sign_up
  def new
    @user = User.new
    @items ||= Item.all
    super
  end

  # POST /resource
  def create
    @user = User.create(user_params)
    redirect_to new_user_session_path if @user.save!
  end

  # UPDATE /resource
  def update
    redirect_to users_dashboard_index_path if resource.update_without_password(user_params)
  end

  protected

  def user_params
    params.require(:user).permit(:name, :age, :gender, :email, :password, :photo, :password_confirmation,
                                 locations_attributes: {},
                                 inventories_attributes: {})
  end
end
