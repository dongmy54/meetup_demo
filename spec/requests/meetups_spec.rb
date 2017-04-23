require 'rails_helper'

RSpec.describe "API_V1::Meetups", :type => :request do

	before do
		 Meetup.create!(title: "test1", description: "descrition1")
         Meetup.create!(title: "test2", description: "descrition2")
        # 由于在测试环境没有数据，先建两笔meetup用于测试
    end

  example "query meetups" do
    
    get "/api/v1/meetups"
    
    expect(response).to have_http_status(200)

    result = {
    	"data": [
    {
      "meetup_title": "test1",
      "meetup_description": "descrition1"
    },
    {
      "meetup_title": "test2",
      "meetup_description": "descrition2"
    }
  ]
    }
    
    # 比较复杂的我们可以先把result列出来（和返回结果一摸一样），再放入eq中 

    expect(response.body).to eq(result.to_json) 
  end

end