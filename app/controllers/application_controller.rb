class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_filter :verify_authenticity_token, if: :devise_controller?

  before_filter :configure_permitted_parameters, if: :devise_controller?

   protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:fname, :lname, :email, :image, :password, :password_confirmation, :facebook, :google_oauth2, :gid, :fid, :number, :make, :model, :imei, :serialno) }
  end

  def after_sign_in_path_for(resource_or_scope)
   if request.env['omniauth.origin']
      redirect_to log_list_path
    end
  end
end
