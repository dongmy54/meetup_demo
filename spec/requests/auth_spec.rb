require 'rails_helper'

RSpec.describe "API_V1::Auth", :type => :request do

  example "register" do
    
    post "/api/v1/signup", params: {:email => "test@example.com", :password => "123456"}
    
    expect(response).to have_http_status(200)
    
    user = User.last      # 找出刚刚建立的使用者
    
    expect(user.email).to eq("test@example.com")
    expect(response.body).to eq({:user_id => user.id}.to_json) 
  end

  example "register faild" do
    post "/api/v1/signup", params: { :email => "123456@qq.com"}

    expect(response).to have_http_status(400)

    expect(response.body).to eq({
      :message => "Failed",
      :errors => { :password => ["can't be blank"]}
      }.to_json)
  end


  example "login" do
    user = User.create!(:email => "test@exmaple.com", :password => "123456")

    post "/api/v1/login", params: { :email => "test@exmaple.com", :password => "123456"}

    expect(response).to have_http_status(200)
    expect(response.body).to eq(
      { :message => "Ok",
        :auth_token => user.authentication_token,
        :user_id => user.id}.to_json)
  end

 
 example "logout" do
    user = User.create!( :email => "test@example.com", :password => "123456")
    auth_token = user.authentication_token
    post "/api/v1/logout", params: {:auth_token => auth_token}

    expect(response).to have_http_status(200)
    expect(response.body).to eq(
      {:message => "Ok"}.to_json) 
  end 

end