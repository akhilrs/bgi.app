class CalllogsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :authenticate_user!, only: [:list]
	@@missing_params
	def submit
		response = {'status' => '', 'message' => ''}
		if !params.has_key?(:auth_code) || !params.has_key?(:serialno)
			response['status'] = 'failed'
			key_missing = (!params.has_key?(:auth_code)) ? 'Authentication' : 'Mobile Serial'
			response['message'] = "Missing #{key_missing} key!"
		else
			auth_code = Rails.application.config.android_authentication_code
			if auth_code == params[:auth_code]
				error = false
				error_message = ""
				params[:data].each do |data|
					if validate(data)
						res = Calllog.add_log(data, params[:serialno])
						if res['status'] != 'success'
							error_message = res['message']
							error = true
							break;
						end
					else
						missing = ""
						@@missing_params.each do |m|
							missing += "#{m}, "
						end
						missing = missing[0..-3]
						response['status'] = 'failed'
						response['message'] =  "Missing Params - #{missing}"
					end
				end

				if error === true
					response['status'] = 'failed'
					response['message'] = "Oops! Something bad happened. #{error_message}"
				else
					response['status'] = 'success'
					response['message'] = 'Data added successfully!'
				end
				# if validate(params)
				# 	#res = CallLog.add_log(params[:data])

				# 	response['status'] = 'success'
				# 	response['message'] = params[:data][:serialno]
				# else
				# 	missing = ""
				# 	@@missing_params.each do |m|
				# 		missing += "#{m}, "
				# 	end
				# 	missing = missing[0..-3]
				# 	response['status'] = 'failed'
				# 	response['message'] =  "Missing Params - #{missing}"
				# end
			else
				response['status'] = 'failed'
				response['message'] = 'Invalid Authentication key!'
			end			
		end
		# params[:data].each do |d|
		# 	puts d[:number]
		# end
		render json: response.to_json		
	end

	def list
		if !current_user.blank?
			user = User.find(current_user)
			@calllogs = user.phones.first.calllogs
			if @calllogs.nil?
				@log = false
			else
				@log = true
			end
		end
	end


	private 
	def validate(params)
		requiredParams = ['number','type', 'datetime', 'duration']
		@@missing_params = requiredParams-params.keys
		valid = true
		if @@missing_params.any?
			valid = false
		end
		return valid
	end
end
