class UsersController < ApplicationController
	before_filter :authenticate, only: [:edit, :update]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :destroy

	def new
		@user = User.new
		@title = "Sign up!"
	end

	def create
		@user = User.new(params[:user])
		if @user.save
  			session[:user_id] = @user.id
			redirect_to root_path, notice: "Signed up!"
		else
			render "new"
		end  	
	end

	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			redirect_to root_path
			flash[:success] = "Your have updated your settings successfully."
		else
			flash.now[:error] = "Sorry! We are unable to update your settings. Please check your fields and try again."
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_path		
	end

	def index
		@user = current_user
		@users = User.all
	end

	private

		def authenticate
			unless current_user
				store_location
				redirect_to login_path 
				flash[:error] = "Sorry, you have to login to view this page."
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_path unless current_user?(@user)	
		end

		def admin_user
			redirect_to root_path unless current_user.admin?
		end
end
