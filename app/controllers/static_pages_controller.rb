class StaticPagesController < ApplicationController

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
