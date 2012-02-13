class CollectionsController < ApplicationController
	before_filter :authenticate, only: [:create, :destroy]

	def index
		
	end

	def create
		@collection = current_user.collections.build(params[:collection])
		if @collection.save
			flash[:success] = "New collection added."
			redirect_to shop_user_path(current_user)
		else
			flash[:error] = "Sorry, there seems to be an error adding your collection. Why don't you try again?"
			redirect_to shop_user_path(current_user)
		end
	end

	def destroy
		@collection = current_user.collections.find_by_id(params[:id])
		@collection.destroy
		flash[:success] = "Collection deleted."
		redirect_to shop_user_path(current_user)
	end

end
