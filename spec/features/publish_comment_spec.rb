require "rails_helper"

feature "Publish Comment", :type => :feature do 
	
	scenario "publish_comment" do
		user = User.create!( :email => "test@example.com", :password => "123456")
		meetup = Meetup.create!( :title => "test", :description => "this is test")
		#在测试环境下是没有数据的，需要先去创建meetup,和user

		sign_in(user)

		visit "/"

		click_link("test")
		expect(page).to have_content("meetup评论")

		fill_in "Content", :with => "这个meetup还不错"
		# 发现填表单这里，必须要设置label且必须要和数据库中名字相同
		click_button("Submit")
		expect(page).to have_content("这个meetup还不错")
	end

end