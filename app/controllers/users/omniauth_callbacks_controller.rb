class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
      	# You need to implement the method below in your model (e.g. app/models/user.rb)
      	@response = User.authenticate_user(request.env["omniauth.auth"], current_user)

      	#if @user.persisted?
	    #    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
	    #    sign_in_and_redirect @user, :event => :authentication
      	#else
	    #    session["devise.google_data"] = request.env["omniauth.auth"]
	    #    redirect_to new_user_registration_url
      	#end
      	if @response['status'] == 'found'
      		flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      		@user = User.find(@response['userid'])
      		sign_in_and_redirect @user, :event => :authentication
      	else
      		flash[:notice] = "No account found with this google account, Please register using your mobile device."
      		redirect_to root_path
      	end
  	end

  	def facebook
	    # You need to implement the method below in your model (e.g. app/models/user.rb)
	    @response = User.authenticate_user(request.env["omniauth.auth"], current_user)

	    #if @user.persisted?
		#      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
		#      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	    #else
		#      session["devise.facebook_data"] = request.env["omniauth.auth"]
		#      redirect_to new_user_registration_url
	    #end

	    if @response['response'] == 'found'
	    	@user = User.find(@response['userid'])
      		set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      		sign_in_and_redirect @user, :event => :authentication
      	else
      		flash[:notice] = "No account found with this facebook account, Please register using your mobile device."
      		redirect_to root_path
      	end
  	end
end