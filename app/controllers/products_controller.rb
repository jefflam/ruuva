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

	def create
		set_collection_id
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

	private

	def set_collection_id
		@collection = Collection.find(session[:collection_id])
	end

end
