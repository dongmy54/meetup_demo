require "rails_helper"

feature "Publish Meetup", type: :feature do

	before do 
      @user = User.create!( :email => "test@example.com", :password => "123456")
	end

	scenario "publish meetup" do
      sign_in(@user) # 这样登录，不用重复之前登录
   
      visit "/"
      click_link("发表meetup")
      expect(page).to have_content("meetup活动创建")

      fill_in "Title", with: "test"
      fill_in "Description", with: "description"
      click_button("Submit")

      expect(page).to have_content("test")
	end
end
