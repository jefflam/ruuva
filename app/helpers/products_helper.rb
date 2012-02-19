module ProductsHelper

	def toggle_like_product_button(product, user)
		if user.flagged?(product, :like)
			# User already like this
			link_to "Unlike", like_product_path(product), class: "btn btn-small"
		else
			# We have not liked this
			link_to "Like", like_product_path(product), class: "btn btn-small"
		end
	end	
end
