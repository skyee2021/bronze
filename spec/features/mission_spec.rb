require 'rails_helper'
# require 'selenium/webdriver'


feature "mission", :type => :feature do
  before do
    m1 = Mission.create!(title: "m1", start_time: Time.now, end_time: Time.now + 10.minutes, status: "pending", priority: "high")
    m2 = Mission.create!(title: "m2", start_time: Time.now, end_time: Time.now + 2.minutes, status: "done", priority: "low")
    m3 = Mission.create!(title: "m3", start_time: Time.now, end_time: Time.now + 5.minutes, status: "done", priority: "middle")
  end


  scenario "ordered by created_at" do

    visit "/" #首頁
    expect(page).to have_content("新增任務")
    expect(page.body).to match(/m1.*m2.*m3/m)
    click_link "sort_by_end"
    expect(page.body).to match(/m2.*m3.*m1/m)
    click_link "sort_by_priority"
    expect(page.body).to match(/m2.*m3.*m1/m)

    #title search
    within(".mission_search") do 
      fill_in "q_title_cont", with: "m1"
    end
    click_button "commit"
    expect(page.body).to have_content("m1")
    expect(page.body).not_to have_content("m2")

       
    
    visit "/missions/new"
    expect(page).to have_content("任務名稱")
    expect(page).to have_content("返回任務列表")

    
  end
  
  scenario "search status" do
   
    visit "/" #首頁
    #status search
    within("#mission_search") do
      select I18n.t("enums.status.done"), from: 'q_status_eq'
    end
    click_button "commit"
    expect(page.body).to have_content("m2")
    expect(page.body).not_to have_content("m1")
  end
  
end





RSpec.describe MissionsController, type: :controller do
  before(:all) do
    @m3 = Mission.create(title: "m3", start_time: Time.now, end_time: Time.now)
   
  end
  it "#index" do
    get :index
    expect(response).to have_http_status(200)
  end

  it "#edit" do
    get :edit, params: { id: @m3.id }
    expect(response).to have_http_status(200)
  end


  it "#destroy" do
    expect{delete :destroy, params: { id: @m3.id}}.to change{Mission.all.count}.by(-1)
    expect(response).to redirect_to(missions_path)
  end
end

RSpec.describe MissionsController, type: :controller do
  describe "validations" do
    it "presence" do
      mission = Mission.new(title: "11", description: "111", start_time: "", end_time: "")
      mission.save

      expect(mission.errors.full_messages.include?("Title #{I18n.t("errors.messages.blank")}")).to be false
      expect(mission.errors.full_messages.include?("End time #{I18n.t("errors.messages.blank")}")).to be true
    end
  end
end