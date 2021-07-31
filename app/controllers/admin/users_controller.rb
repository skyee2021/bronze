class Admin::UsersController < ApplicationController
  # before_action :current_user
  before_action :no_user_loged
  before_action :authenticate_admin
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
      redirect_to admin_users_path
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
    redirect_to admin_users_path, notice: '帳號已鎖！'
  end

  def unlocked
    @user.update(role: 'member')
    redirect_to admin_users_path, notice: '帳號解鎖！'
  end

  def edit
  end

  def update
    msg = if @user.update(user_params)
      t("successfully_update")
    else
      @user.errors[:role].present? ? t("not_less_one") : t("fail_update")
    end
    redirect_to admin_users_path, notice: msg
    
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path
    else
      redirect_to admin_users_path
    end
  end


  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end

    def find_user
      @user = User.find(params[:id])
    end

end

