class MissionsController < ApplicationController
  before_action :find_mission, only: [:show, :edit, :update, :destroy]
  before_action :no_user_loged
  before_action :check_user_locked

  def index
    @q = current_user.missions.order('created_at').ransack(params[:q])
    @missions = @q.result.includes(:user, :tags).page(params[:page]).per(25)
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = current_user.missions.new(mission_params)
    if @mission.save
      redirect_to missions_path, notice: t('success')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @mission.update(mission_params)
      redirect_to missions_path, notice: t('success')
    else
      render :new
    end
  end

  def destroy
    @mission.destroy
    redirect_to missions_path, notice: t('delete')
  end

  private

  def find_mission
    if current_user.admin?
      @mission = Mission.find(params[:id])
    else
      # user = Mission.find(params[:id]).user_id
      @mission = current_user.missions.find(params[:id])
    end
  end
  
  def mission_params
    params.require(:mission).permit(:title, :description, :status, :start_time, :end_time, :priority, {tag_items: []})
  end

  # def no_user_loged
  #   if current_user.nil?
  #     # session[ENV['session_name']] == nil
  #     redirect_to log_in_sessions_path, notice: t("log_before_start")
  #   end
  # end
end
