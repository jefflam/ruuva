class SessionsController < ApplicationController
  def new
  	@title = "Sign in!"
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_back_or root_path
  	else
  		flash.now[:error] = "Oops, log in failed! Did you enter the correct email and password?"
  		render "new"
  	end
  end

  def create_facebook_auth
    auth_hash = request.env['omniauth.auth']
    render :text => auth_hash.inspect
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: "Logged out."
  end
end
