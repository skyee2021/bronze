require 'rails_helper'
require 'selenium/webdriver'


feature "mission", :type => :feature do
  

  scenario "ordered by created_at" do

    visit "/" #首頁
    expect(page).to have_content("新增任務")
    
    visit "/missions/new"
    expect(page).to have_content("任務名稱")
    expect(page).to have_content("返回任務列表")
  end

end

describe "mission list" do
  
  
  scenario "order by created_at", js: true do
    m1 = Mission.create!(title: "m1")
    m2 = Mission.create!(title: "m2")
    
    visit "/"
    expect(page.body).to match(/m1.*m2/m)
  end
end