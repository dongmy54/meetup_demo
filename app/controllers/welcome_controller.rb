class WelcomeController < ApplicationController

	def index
		flash[:alert] = "亲，您好！"
	end
end
