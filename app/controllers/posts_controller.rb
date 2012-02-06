class PostsController < ApplicationController
	before_filter :authenticate, only: [:create, :destroy]
	before_filter :authorized_user, only: :destroy

	def index
		
	end

	def create
		@posts = current_user.posts.build(params[:post])
		if @posts.save
			flash[:success] = "New post added!"
			redirect_to root_path
		else
			flash[:error] = "Hmmm, we are unable to add your new post."
			redirect_to root_path
		end
	end

	def destroy
		@post.destroy
		redirect_back_or root_path
	end

	private

		def authorized_user
			@post = current_user.posts.find_by_id(params[:id])
			redirect_to root_path if @post.nil?
			
		end
end
