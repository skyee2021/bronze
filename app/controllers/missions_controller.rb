class MissionsController < ApplicationController
  before_action :find_mission, only: [:show, :edit, :update, :destroy]

  def index
    @missions = Mission.all
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)
    if @mission.save
      redirect_to missions_path, notice: '成功'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mission.update(mission_params)
      redirect_to missions_path, notice: '修改成功'
    else
      render :new
    end
  end

  def destroy
    @mission.destroy
    redirect_to missions_path, notice: '刪除任務'
  end



  private
  def find_mission
    @mission = Mission.find(params[:id])
  end
  
  def mission_params
    params.require(:mission).permit(:title, :description)
  end
end
