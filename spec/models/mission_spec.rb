require 'rails_helper'

RSpec.describe Mission, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "任務" do
    it "mission_status is pending" do
      mission = Mission.new(status:"pending")
      expect(mission.status).to eq "pending"

    end
  end
  

end
