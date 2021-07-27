require 'rails_helper'

RSpec.describe Mission, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    # user = User.create(id: 3, email: "aaa@aa.aa", password: "123123")
  end

  context "任務" do
    it "mission_status is pending" do
      mission = Mission.new(title: "m1", start_time: Time.now, end_time: Time.now, status:"pending")
      expect(mission.status).to eq "pending"
      mission2 = Mission.create(title: "m2", start_time: Time.now, end_time: Time.now, status:"pending")
      expect(mission2).to eq(Mission.last)
    end
  end

  context "validates" do
    it "title is nil" do
      m3 = Mission.new(title: nil)
      expect(m3).to_not be_valid
    end
    it "title is not nil" do
      m4 = Mission.new(title: "m4", start_time: Time.now, end_time: Time.now, status:"pending")
      expect(m4).to be_valid
    end

    it "end-time" do
      mission = Mission.new(title: "m4", start_time: Time.now, end_time: Time.now - 2.minutes)
      mission.save

      expect(mission.errors.full_messages.include?("End at #{I18n.t("later_than_start_at")}")).to be false
    end
  end
  


end
