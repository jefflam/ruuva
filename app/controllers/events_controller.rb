class EventsController < ApplicationController
	before_filter :authenticate
	before_filter :set_collection_id, only: [:new, :create, :destroy]

	def attending
		@current_user = current_user
		@event = Event.find(params[:id])

		if @current_user.flagged?(@event, :attending)
			# User has attended it, let's UNattend it
			@current_user.unflag(@event, :attending)
			redirect_to event_path(@event)
			flash[:success] = "You are not attending this event."			
		else
			# User has not attend it yet, let's attend it
			@current_user.flag(@event, :attending)
			redirect_to event_path(@event)
			flash[:success] = "You are attending this event."			
		end
	end

	def show
		@event = Event.find(params[:id])
		@collection_id = @event.collection_id
		@collection = Collection.find(@collection_id)
		@user_id = @collection.user_id
		@user = User.find(@user_id)		
		@title = "Events Page"		
	end

	def new
		@collection_id = Collection.find(@collection.id)
		@event = Event.new
		@user = current_user
		@title = "Create a new event."
	end

	def create
		@event = @collection.events.build(params[:event])
		# also auto post update to wall with collection name and collection description
		@post = current_user.posts
		if @event.save
			@post.build(content: "New event added to collection: #{@collection.name}. It's happening at #{@event.date_time.in_time_zone("Singapore")}.").save	
			flash[:success] = "New event added."
			redirect_to shop_user_path(current_user)
		else
			flash[:error] = "Sorry, there seems to be an error with adding your new event. Why don't you try again?"
			redirect_to shop_user_path(current_user)
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.delete
		flash[:info] = "Event cancelled."
		redirect_to shop_user_path(current_user)
	end

	def edit
		@event = Event.find(params[:id])
		@collection_id = @event.collection_id
		@collection = Collection.find(@collection_id)
		@user_id = @collection.user_id
		@user = User.find(@user_id)				
		@title = "Edit your event's details."
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(params[:event])
			redirect_back_or root_path
			flash[:success] = "Your have updated your event details successfully."
		else
			flash.now[:error] = "Sorry! We are unable to update your event details. Please check your fields and try again."
			render 'edit'
		end
	end	
end
