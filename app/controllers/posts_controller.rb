class PostsController < ApplicationController
	before_filter :authenticate, only: [:create, :destroy]
	before_filter :authorized_user, only: :destroy

	def index
		
	end

	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			flash[:success] = "New post added!"
			redirect_to root_path
		else
			flash[:error] = "Hmmm, we are unable to add your new post."
			redirect_to root_path
		end
	end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted."
		redirect_back_or root_path
	end

end
