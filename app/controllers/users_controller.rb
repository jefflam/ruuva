class UsersController < ApplicationController
	before_filter :authenticate, except: [:show, :new, :create, :index]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :destroy
	before_filter :store_location, only: :shop

	def new
		@user = User.new
		@title = "Sign up for Ruuva!"
	end

	def create
		@user = User.new(params[:user])
		if @user.save
  			UserMailer.registration_mail(@user).deliver
  			session[:user_id] = @user.id
  			@user.follow!(User.find(1)) # Follow Ruuva Team's Account by default
			flash[:success] = "Hello there! You've successfully signed up for Ruuva!"  			
			redirect_to root_path
		else
			flash[:error] = "Sorry, there seems to be an error with your sign up... please try again!"
			redirect_to signup_path
		end  	
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts
		@title = @user.name
	end

	def edit
		@user = User.find(params[:id])
		@title = "Edit Your Account Settings"
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user]) 
			redirect_back_or root_path
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
		@title = "Ruuva Marketplace"
	end

	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers
		render 'show_follow'
	end	

	def shop
		@user = User.find(params[:id])		
		@title = @user.name
		@collection = Collection.new
		@collections = @user.collections
		render 'shop'
	end

	private

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_path unless current_user?(@user)	
		end

		def admin_user
			redirect_to root_path unless current_user.admin?
		end
end
