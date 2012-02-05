class PagesController < ApplicationController
 
	def home
		@title = "Simplifying and socializing online shopping - Ruuva"
		@user = current_user
	end

end
