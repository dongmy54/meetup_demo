class ApiController < ActionController::Base

	before_action :authenticate_user_from_token!

	def authenticate_user_from_token!
		
		if params[:auth_token].present?
			user = User.find_by_authentication_token( params[:auth_token])

			# sign_in 是 devise的方法
			sign_in(user, store: false) if user
		end
	end
	# authenticate_user_from_token!用于接受auth_token参数，如果有会尝试登陆
end
