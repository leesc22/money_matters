class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def signed_in?
  	!current_user.nil?
  end
  helper_method :current_user, :signed_in?

  def authorize
  	redirect_to sign_in_path unless current_user
	end
end
