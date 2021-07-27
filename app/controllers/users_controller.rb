class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :locked]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params_edit)
      redirect_to root_path, notice: t("successfully_update_user")
    else
      render :edit
    end
  end


  # def locked
  #   @user = User.find(params[:id])
  #   @user.locked
  #   redirect_to qqaazzxxssww_user_path(@user.id)
  # end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_params_edit
    params.require(:user).permit(:password, :password_confirmation)
  end

  def find_user
    @user = User.find_by!(id: session[ENV['session_name']])

    redirect_to locked_users_path if @user.role == "locked"

  # rescue ActiveRecord::RecordNotFound
  #   redirect_to root_path, notice: t("user_not_found")
  end
end
