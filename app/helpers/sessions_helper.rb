module SessionsHelper
	def current_user
	  @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
	end

	def user_signed_in?
	  !current_user.nil?
	end

	def log_in(user)
	  session[:user_id] = user.id
	end
	def log_out
	  session.delete(:user_id)
	  @current_user = nil
	end
end