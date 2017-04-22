class Api::V1::MeetupsController < ApiController
   
    def index
    	@meetups = Meetup.all

        # 需要注意：这里不能用循环去 render :json，因为只能导一次
    	render :json => {
    		:data => @meetups.map { |meetup|
              {
              	:meetup_title => meetup.title,
    		    :meetup_description => meetup.description 
              }
    		}
    	}
    end

end
