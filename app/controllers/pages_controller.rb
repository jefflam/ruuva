class PagesController < ApplicationController
 
  def home
  	@title = "Simplifying and socializing online shopping - Ruuva"
  end

  def contact
  	@title = "Contact Us"
  end

  def about
  	@title = "About Ruuva"
  end

  def terms
  	@title = "Terms & Conditions"
  end

  def help
  	@title = "Ruuva Help Guide"
  end

end
