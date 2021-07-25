require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"


  context "email驗證" do
    it "no @" do
      user = User.create(email: "aaaaa.aa", password: "123123")
      user.valid?
      expect(user).to_not be_valid
    end


    it "相同email不能註冊" do
      user = User.create(email: "aaa@aa.aa", password: "123123")
      user.save
      user2 = User.create(email: "aaa@aa.aa", password: "123123")
      user2.valid?
      expect(user2).to_not be_valid
    end
  end


end
