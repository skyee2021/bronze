require 'rails_helper'

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
  let!(:m1) {Mission.create(:mission, title: "m1", description: "xx1")}
  let!(:m2) {Mission.create(:mission, title: "m2", description: "xx2")}
  let!(:expect_order) {%w[m1 m2]}
  before :each do
    m1
    m2
    visit "/"
  end

  scenario "order by created_at", js: true do
    res = all('tr td .title').map
    expect(res).to eq(expect_order)
  end
end