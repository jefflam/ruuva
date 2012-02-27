class PagesController < ApplicationController
	before_filter :store_location, only: :home

 
	def home
		@title = "Ruuva | Online Shopping Eyecandy"
		@meta_description = "Ruuva satisfies your online social shopping eyecandy needs."
		@user = current_user
		if current_user
			@post = Post.new
			@feed_items = current_user.feed

			@user_following = @user.following
			@user_followers = @user.followers

			@events_attending = @user.flaggings.with_flag(:attending)
		end
	end

end