class UsersController < ApplicationController
	# before_filter :authenticate, only: [:edit, :update]

	def new
		@user = User.new
		@title = "Sign up!"
	end

	def create
		@user = User.new(params[:user])
		if @user.save
  			session[:user_id] = @user.id
			redirect_to @user, notice: "Signed up!"
		else
			render "new"
		end  	
	end

	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	# private

	# 	def authenticate
	# 		deny_access unless current_user
	# 	end
end
