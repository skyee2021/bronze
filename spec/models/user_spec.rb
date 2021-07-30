require 'rails_helper'

RSpec.describe User, type: :model do


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

  context "管理員" do
    it "管理員不能少於一位" do
      admin = User.create(email: "user@mail.com", password: "123123", role: "admin")
      user = User.create(email: "user@mail.com", password: "123123", role: "member")
      admin.destroy
      expect(admin.errors[:role]).to include I18n.t("not_less_one")
    end
  end


end
