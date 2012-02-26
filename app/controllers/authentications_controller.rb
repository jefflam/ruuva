class AuthenticationsController < ApplicationController
  def index
  end

  def create
	  auth_hash = request.env['omniauth.auth']
	  # render :text => auth_hash["info"]["image"].to_yaml 
	  @authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	  if @authentication
	  	user = User.find(@authentication.user_id)
  		UserMailer.registration_mail(user).deliver # send welcome mail 	  	
	  	session[:user_id] = user.id
	  	redirect_to root_path
	  else
	    user = User.new(name: auth_hash["info"]["name"], 
	    				email: auth_hash["info"]["email"],
	    				remote_avatar_url: auth_hash["info"]["image"],
	    				password_digest: "ThisIsAPasswordDigiestOmniAuthHack") # Hack to overwrite password_digest validation
	    user.authentications.build(provider: auth_hash["provider"], uid: auth_hash["uid"])
	    user.save(validate: false)
  		UserMailer.registration_mail(user).deliver # send welcome mail 
     	session[:user_id] = user.id
		flash[:success] = "Hello there! You've successfully logged in for Ruuva with your Facebook account!" 
		redirect_to root_path
	  end
  end

  def destroy
  end

  def failure
  	flash[:error] = "You did not allow access to our application on Facebook! :( Perhaps you may want to create an account instead on Ruuva?"
  	redirect_to signup_path
  end
end
