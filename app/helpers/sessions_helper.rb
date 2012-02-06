module SessionsHelper

	def current_user?(user)
		user == current_user
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end

	def store_location
		session[:return_to] = request.fullpath
	end

	private

		def authenticate
			unless current_user
				store_location
				redirect_to login_path 
				flash[:error] = "Sorry, you have to login to view this page."
			end
		end	

		def clear_return_to
			session.delete(:return_to)
		end
end
