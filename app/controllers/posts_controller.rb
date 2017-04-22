class PostsController < ApplicationController

	def create
		@meetup = Meetup.find(params[:meetup_id])
		@post = Post.new(params_post)
        @post.meetup = @meetup
        if @post.save
        	redirect_to meetup_path(@meetup)
        end
	end

	private

	def params_post
		params.require(:post).permit(:content)
	end
end
