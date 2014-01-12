class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_filter :verify_authenticity_token, if: :devise_controller?

  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_filter :store_location

   
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:fname, :lname, :email, :image, :password, :password_confirmation, :facebook, :google_oauth2, :gid, :fid, :number, :make, :model, :imei, :serialno) }
  end

  def store_location
  	# store last url - this is needed for post-login redirect to whatever the user last visited.
	  if (request.fullpath != "/users/sign_in" &&
	      request.fullpath != "/users/sign_up" &&
	      request.fullpath != "/users/password" &&
	      !request.xhr?) # don't store ajax calls
	    session[:previous_url] = request.fullpath 
	  end
  end

  	def after_sign_in_path_for(resource)
  		session[:previous_url] || root_path
	end
end
