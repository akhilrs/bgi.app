class RegistrationsController < Devise::RegistrationsController
	@@missing_params
	def create
		@params = sign_up_params
			@userpara = {'email' => 'akhil@breezegoindia.com', 'password' => @params["password"],
				'fname' => 'Akhil'}
			build_resource(@userpara)
			if resource.save
				yield resource if block_given?
			      if resource.active_for_authentication?
			        #set_flash_message :notice, :signed_up if is_flashing_format?
			        sign_up(resource_name, resource)
			        #respond_with resource, :location => after_sign_up_path_for(resource)
			        responds = {'status' =>'success'}
			      else
			        #set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
			        expire_data_after_sign_in!
			        #respond_with resource, :location => after_inactive_sign_up_path_for(resource)
			        responds = {'status' => 'failed'}
			      end
			else
				responds = {'status' => 'failed'}
			end
		render json: responds.to_json
  	end

  	def mobile_signin
  		password = Devise.friendly_token[0,20]
  		auth_code = Rails.application.config.android_authentication_code
  		if params.has_key?(:auth_code)
	  		if auth_code == params[:auth_code]
	  			if validate(params) == true
		  			user = User.authenticate_user_mobile(params)
		  			if user['found'] == true && params[:provider] == user['provider']
 						@user = User.where(:email => params[:email]).first
		  			elsif user['found'] == true && params[:provider] != user['provider']
		  				@user = User.update_user(params)
		  			else
		  				@user = User.create_user(params)
		  			end
		  			if @user.persisted?
		  				render json: {'status' => 'success', 'message' => 'Signed in successfully!'}
		  			else
		  				render json: {'status' => 'failed', 'message' => 'Oops something wrong happened!'}
		  			end
	  			else
	  				missing = ""
	  				@@missing_params.each do |m|
	  					missing += "#{m}, "
	  				end
	  				missing = missing[0..-3]
	  				render json: {'status' => 'failed', 'message' => "Missing Params - #{missing}" }
	  			end
	  		else
	  			render json: {'status' => 'failed', 'message' => 'Invalid Authentication Code!'}
	  		end
	  	else
	  		render json: {'status' => 'failed', 'message' => 'Missing authentication code!'}
	  	end
  	end


  	def validate(params)
		requiredParams = ['fname', 'email', 'auth_code','provider', 'uid', 'number', 'imei', 'serialno']
		@@missing_params = requiredParams-params.keys
		valid = true
		if @@missing_params.any?
			valid = false
		end
		return valid
	end
end
