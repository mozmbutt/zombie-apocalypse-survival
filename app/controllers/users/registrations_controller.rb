# frozen_string_literal: true

# User is our app user, that could be survivor or admin by role
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
    # redirect_to new_user_session_path if @user.save!

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_user_session_path, notice: 'Successfully Account Created.' }
      else
        @items ||= Item.all
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # UPDATE /resource
  def update
    redirect_to new_user_session_path if resource.update(user_params)
  end

  protected

  def user_params
    params.require(:user).permit(:name, :age, :gender, :email, :password, :photo, :password_confirmation,
                                 locations_attributes: %i[lat lng],
                                 inventories_attributes: %i[user_id item_id stock])
  end
end
