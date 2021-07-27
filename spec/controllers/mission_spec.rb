require 'rails_helper'

RSpec.describe MissionsController, type: :controller do
  let(:user) { User.create(email: 'aaa@aa.aa', password: '123456') }
  let(:mission) {user.missions.create(title: "m3", start_time: Time.now, end_time: Time.now)}

  before do
    session[ENV['session_name']] = user.id
    session[ENV["user_role"]] = user.role
    session[ENV["user_email"]] = user.email    
    
    # u1 = User.create(email: "aaaa@aa.aa", password: "123456")
    @m3 = user.missions.create(title: "m3", start_time: Time.now, end_time: Time.now)
   
  end
  it "#index" do
    get :index
    expect(response).to have_http_status(200)
  end

  it "#edit" do
    get :edit, params: { id: mission.id }
    expect(response).to have_http_status(200)
  end

  it "#create" do
    params ={mission: {title: "m3", start_time: Time.now, status: "pending", priority: "low", end_time: Time.now + 2.minutes}}
    post :create, params: params
    expect(response).to have_http_status(302)
    expect(Mission.last.title).to include("m3")
  end


  it "#destroy" do
    m3 = user.missions.create(title: "m3", start_time: Time.now, end_time: Time.now)
    # byebug
    expect{delete :destroy, params: {id: user.missions.find(mission.id)}}.to change{Mission.where(user_id: user.id).count}.by(0)
    # post :destroy, params: {id: user.missions.find(mission.id)}
    # expect(Mission.where(user_id: user.id).count).to change(-1)
    expect(response).to redirect_to(missions_path)
  end



  describe "validations" do
    it "presence" do
      mission = Mission.new(title: "11", description: "111", start_time: "", end_time: "")
      mission.save

      expect(mission.errors.full_messages.include?("Title #{I18n.t("errors.messages.blank")}")).to be false
      expect(mission.errors.full_messages.include?("End time #{I18n.t("errors.messages.blank")}")).to be true
    end
  end
end