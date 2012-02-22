class CollectionsController < ApplicationController
	before_filter :authenticate, only: [:create, :destroy]
	before_filter :store_location, only: :show	
	before_filter :current_collection, only: :show

	def like
		@current_user = current_user
		@collection = Collection.find(params[:id])

		if @current_user.flagged?(@collection, :like)
			# User has liked it, let's UNlike it
			@current_user.unflag(@collection, :like)
			redirect_to shop_user_path(@user)
			flash[:success] = "You have unliked this collection."			
		else
			# User has not like it yet, let's like it
			@current_user.flag(@collection, :like)
			redirect_to shop_user_path(@user)
			flash[:success] = "You have liked this collection!"			
		end
	end

	def show
		@title = "Collection"
		collection_user_id = Collection.find(params[:id]).user_id
		@user = User.find(collection_user_id)
		@product = Product.new
		@products = Collection.find(params[:id]).products
		@collection = Collection.find(params[:id])
		@event = @collection.events
		@event_id = Event.find_by_collection_id(params[:id])
	end

	def create
		@collection = current_user.collections.build(params[:collection])
		# also auto post update to wall with collection name and collection description
		@post = current_user.posts
		if @collection.save
			@post.build(content: "New collection added: #{@collection.name}. Description: #{@collection.description}").save
			flash[:success] = "New collection added."
			redirect_to shop_user_path(current_user)
		else
			flash[:error] = "Sorry, there seems to be an error adding your collection. Why don't you try again?"
			redirect_to shop_user_path(current_user)
		end
	end

	def destroy
		@collection = current_user.collections.find_by_id(params[:id])
		@collection.delete
		flash[:success] = "Collection deleted."
		redirect_to shop_user_path(current_user)
	end

	def edit
		@collection = current_user.collections.find_by_id(params[:id])
		@user = current_user
	end

	def update
		@collection = Collection.find(params[:id])
		if @collection.update_attributes(params[:collection])
			redirect_back_or root_path
			flash[:success] = "Your have updated your collection details successfully."
		else
			flash.now[:error] = "Sorry! We are unable to update your collection details. Please check your fields and try again."
			render 'edit'
		end		
	end

	private

		def current_collection
			session[:collection_id] = Collection.find(params[:id]).id.to_i
		end

end
