# Rails Script to Delete Events

@event = Event.first

@event_to_delete = @event <=> Time.now - 1.hour

if @event_to_delete = -1
	@event.delete
end