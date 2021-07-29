require 'rails_helper'

RSpec.describe Mission, type: :model do

  let(:user){ User.create(id: 3, email: "aaa@aa.aa", password: "123123")}
  

  describe "任務" do
    it "mission_status is pending" do
      mission = user.missions.new(title: "m1", start_time: Time.now, end_time: Time.now, status:"pending")
      expect(mission.status).to eq "pending"
    end
    
    it "mission_create_sort_by_creat_time" do
      mission2 = user.missions.create(title: "m2", start_time: Time.now, end_time: Time.now, status:"pending")
      expect(mission2).to eq(Mission.last)
    end
  end

  describe "validates" do
    let(:m3){user.missions.new(title: nil)}
    let(:m4){user.missions.new(title: "m4", start_time: Time.now, end_time: Time.now, status:"pending")}
    let(:mission){user.missions.new(title: "m4", start_time: Time.now, end_time: Time.now - 2.minutes)}

    it "title is nil" do
      # m3 = user.missions.new(title: nil)
      expect(m3).to_not be_valid
    end

    it "title is not nil" do
      # m4 = user.missions.new(title: "m4", start_time: Time.now, end_time: Time.now, status:"pending")
      expect(m4).to be_valid
    end

    it "end-time" do
      # mission = user.missions.new(title: "m4", start_time: Time.now, end_time: Time.now - 2.minutes)
      mission.save
      expect(mission.errors.full_messages.include?("End at #{I18n.t("later_than_start_at")}")).to be false
    end
  end
  

end
