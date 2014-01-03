class RegistrationsController < Devise::RegistrationsController
	def create
		@password = sign_up_params
  	end
end
