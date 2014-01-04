class RegistrationsController < Devise::RegistrationsController
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
end
