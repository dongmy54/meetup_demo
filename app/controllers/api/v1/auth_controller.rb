class Api::V1::AuthController < ApiController
	before_action :authenticate_user!, only: [:logout]
	              # 退出时验证是否是使用者

	def signup
		user = User.new( :email => params[:email], :password => params[:password] )
        
        if user.save
        	render :json => { :user_id => user.id }
        else
        	render :json => { :message => "Failed", :errors => user.errors },
        	:status => 400
        end
	end

	def login
		if params[:email] && params[:password]       # 先确保邮箱和密码都填写了才进一步查询
		   user = User.find_by_email(params[:email])
	    end
          
            # 我们不能直接用： user.password == params[:password]去判断，因为user的密码是查不出来的，为nil
		if user && user.valid_password?( params[:password])
			render :json => { :meesage => "Ok",
			                  :auth_token => user.authentication_token,
			                  :user_id => user.id }
		else
			render :json => { :message => "Email or Password is wrong"},
			:status => 401
		end
	end

	def logout
		current_user.generate_authentication_token # 重新产生token号，让之前的号失效
		current_user.save!
        
		render :json => { :message => "Ok"}
	end

end
