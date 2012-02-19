module CollectionsHelper

	def toggle_like_collection_button(collection, user)
		if user.flagged?(collection, :like)
			# User already like this
			link_to "Unlike", like_collection_path(collection), class: "btn btn-small"
		else
			# We have not liked this
			link_to "Like", like_collection_path(collection), class: "btn btn-small"
		end
	end

end
