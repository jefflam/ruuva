class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper_method :current_user

  def current_user
  	current_user = User.find(session[:user_id]) if session[:user_id]
  end

  	private

		def authorized_user
			@post = current_user.posts.find_by_id(params[:id])
			redirect_to root_path if @post.nil?
		end
end
