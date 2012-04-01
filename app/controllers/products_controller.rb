class ProductsController < ApplicationController
	before_filter :authenticate, except: :like
	before_filter :set_collection_id, except: :like

	def like
		@user = current_user
		@product = Product.find_by_id(params[:id])

		if @user.flagged?(@product, :like)
			# User has liked it, let's UNlike it
			@user.unflag(@product, :like)
			redirect_to collection_path(session[:collection_id])
			flash[:success] = "You have unliked this product."			
		else
			# User has not like it yet, let's like it
			@user.flag(@product, :like)
			redirect_to collection_path(session[:collection_id])
			flash[:success] = "You have liked this product!"			
		end
	end

	def show
		@title = "Product"
		collection_user_id = @collection.user_id		
		@user = User.find(collection_user_id)		
		@product = Product.find_by_id(params[:id])
		@event = @collection.events
		@event_id = Event.find_by_collection_id(params[:id])
	end

	def create
		@product = @collection.products.build(params[:product]) 
		# also auto post update to wall with product name and product description
		@post = current_user.posts
		if @product.save
			flash[:success] = "New product added."
			@post.build(content: "New product added: #{@product.name} to collection #{@collection.name}. Description: #{@product.description}",
						image_url: @product.product_image_url(:product).to_s).save
			redirect_to collection_path(session[:collection_id])
		else
			flash[:error] = "Sorry, there seems to be an error adding your product. Why don't you try again?"
			redirect_to collection_path(session[:collection_id])
		end
	end

	def destroy
		@product = @collection.products.find_by_id(params[:id])
		@product.delete
		flash[:success] = "Product deleted."
		redirect_to collection_path(session[:collection_id])
	end

	def edit
		@title = "Edit Product Settings"
		collection_user_id = @collection.user_id		
		@user = User.find(collection_user_id)		
		@product = Product.find_by_id(params[:id])
		@event = @collection.events
		@event_id = Event.find_by_collection_id(params[:id])		
	end

	def update
		@product = Product.find_by_id(params[:id])
		if @product.update_attributes(params[:product])
			redirect_back_or root_path
			flash[:success] = "Your have updated your product details successfully."
		else
			flash.now[:error] = "Sorry! We are unable to update your product details. Please check your fields and try again."
			render 'edit'
		end
	end		

	private

	def set_collection_id
		@collection = Collection.find(session[:collection_id])
	end

end
