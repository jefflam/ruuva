module ApplicationHelper

	def title
		base_title = "Ruuva - Simplifying and socializing online shopping"
		if @title.nil?
			base_title
		else
			"#{@title}"	
		end
	end
end
