require 'rails_helper'
# require 'selenium/webdriver'


feature "mission", :type => :feature do


  scenario "ordered by created_at" do
    m1 = Mission.create!(title: "m1")
    m2 = Mission.create!(title: "m2")

    visit "/" #首頁
    expect(page).to have_content("新增任務")
    expect(page.body).to match(/m1.*m2/m)
    
    visit "/missions/new"
    expect(page).to have_content("任務名稱")
    expect(page).to have_content("返回任務列表")

    

  end

end
