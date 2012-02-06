class PagesController < ApplicationController
 
	def home
		@title = "Simplifying and socializing online shopping - Ruuva"
		@user = current_user		
		if current_user
			@post = Post.new
			@feed_items = current_user.feed
		end
	end

end
