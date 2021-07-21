class MissionsController < ApplicationController
  before_action :find_mission, only: [:show, :edit, :update, :destroy]

  def index
    @q = Mission.order('created_at').ransack(params[:q])
    @missions = @q.result.page(params[:page]).per(10)
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)
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
    @mission = Mission.find(params[:id])
  end
  
  def mission_params
    params.require(:mission).permit(:title, :description, :status, :start_time, :end_time, :priority)
  end
end
