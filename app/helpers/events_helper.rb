module EventsHelper

	def toggle_attending_event_button(event, user)
		if user.flagged?(event, :attending)
			# User already attend this
			link_to "Retract Attending", attending_event_path(event), class: "btn btn-medium"
		else
			# We have not attend this
			link_to "Attend this Event", attending_event_path(event), class: "btn btn-medium btn-success"
		end
	end
end
