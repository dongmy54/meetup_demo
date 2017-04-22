class MeetupsController < ApplicationController

	def index
		@meetups = Meetup.all
	end

	def new
		@meetup = Meetup.new
	end

	def create
		@meetup = Meetup.new(params_meetup)
	    if @meetup.save
           redirect_to meetups_path
           flash[:notice] = "#{@meetup.title}活动创建成功"
        else
           render new	    	
	    end
	end

	private

	def params_meetup
		params.require(:meetup).permit(:title,:description)
	end

end
