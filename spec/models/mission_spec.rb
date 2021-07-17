require 'rails_helper'

RSpec.describe Mission, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "任務" do
    it "mission_status is pending" do
      mission = Mission.new(status:"pending")
      expect(mission.status).to eq "pending"
      mission2 = Mission.create(title:"m2")
      expect(mission2).to eq(Mission.last)
    end
  end
  

end
