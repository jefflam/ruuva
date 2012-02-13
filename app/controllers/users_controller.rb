class UsersController < ApplicationController
	before_filter :authenticate, except: [:show, :new, :create, :index]
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
  			@user.follow!(User.find(1))
			redirect_to root_path
			flash[:success] = "Signed up!"
		else
			render "new"
		end  	
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts
		@title = @user.name
	end

	def edit
		@user = User.find(params[:id])
		@title = "Your Account Settings"
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			if @user.shop?
				redirect_to shop_user_path(current_user)
			else
				redirect_to root_path
			end
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
		@title = "My Shop"
		@user = User.find(params[:id])
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
