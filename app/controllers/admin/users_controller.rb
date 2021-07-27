class Admin::UsersController < ApplicationController
  before_action :current_user
  before_action :authenticate_admin_or_org
  before_action :user_loged_in?
  before_action :find_user, only: [:show, :edit, :update, :destroy, :locked, :unlocked]

  def index
    @q = User.order('created_at').ransack(params[:q])
    @all_users = @q.result.includes(:missions).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to qqaazzxxssww_users_path
    else
      render :new
    end
  end


  def show
    @q = @user.missions.ransack(params[:q])
    @missions = @q.result.order(created_at: :asc).page(params[:page]).per(25)
  end

  def locked
    @user.update(role: 'locked')
    # @user.update(role: 'locked')
    redirect_to qqaazzxxssww_user_path, notice: '帳號已鎖！'
  end

  def unlocked
    @user.update(role: 'member')
    # @user.update(role: 'locked')
    redirect_to qqaazzxxssww_user_path, notice: '帳號解鎖！'
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to qqaazzxxssww_users_path, notice: t("successfully_update_user")
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to qqaazzxxssww_users_path
    else
      redirect_to qqaazzxxssww_users_path
    end
  end

  # def authenticate_admin_or_org
  #   unless current_user.admin!
  #     flash[:alert] = '你沒有權限進入！'
  #     redirect_to root_path
  #   end
  # end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end

    def find_user
      @user = User.find(params[:id])
    end

end

