class UsersController < ApplicationController
  before_action :check_user_locked, only: [:locked]
  before_action :no_user_loged

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
    if current_user.update(user_params_edit)
      redirect_to root_path, notice: t("successfully_update")
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

  # def check_user_locked
  #   # @user = User.find_by!(id: session[ENV['session_name']])
  #   @user = current_user

  #   redirect_to locked_users_path if @user.locked?

  # # rescue ActiveRecord::RecordNotFound
  # #   redirect_to root_path, notice: t("user_not_found")
  # end
end
