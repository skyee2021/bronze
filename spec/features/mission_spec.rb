require 'rails_helper'
# require 'selenium/webdriver'


feature "mission", :type => :feature do
  before do
    m1 = Mission.create(title: "m1", start_time: Time.now, end_time: Time.now + 10.minutes, status: "pending", priority: "high")
    m2 = Mission.create(title: "m2", start_time: Time.now, end_time: Time.now + 2.minutes, status: "done", priority: "low")
    m3 = Mission.create(title: "m3", start_time: Time.now, end_time: Time.now + 5.minutes, status: "done", priority: "middle")
  end


  scenario "ordered by created_at" do

    visit "/" #首頁
    expect(page).to have_content("新增任務")
    # expect(page).to include("m1")
    # expect(body.index(@m1.title)).to be body.index(@m2.title)
    mission_order = page.all('.mission_title').map(&:text)
    expect(mission_order).to eq(["m1", "m2", "m3"])
    # byebug

    # expect(all.).to match(/m3/m)
    # missions = Mission.ransack({s: "created_at"}).result
    # expect(missions).to eq([@m1, @m2, @m3])
    
    click_link "sort_by_end"
    mission_order = page.all('.mission_title').map(&:text)
    expect(page.body).to match(/m2.*m3.*m1/m)
    expect(mission_order).to eq(["m2", "m3", "m1"])
    # expect(body.index(@m2.title)).to be < body.index(@m3.title)
    
    click_link "sort_by_priority"
    mission_order = page.all('.mission_title').map(&:text)
    expect(page.body).to match(/m2.*m3.*m1/m)
    expect(mission_order).to eq(["m2", "m3", "m1"])


    #title search
    within(".mission_search") do 
      fill_in "q_title_cont", with: "m1"
    end
    click_button "submit"
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
    click_button "submit"
    expect(page.body).to have_content("m2")
    expect(page.body).not_to have_content("m1")
  end

    
 
  
end





