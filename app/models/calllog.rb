class Calllog < ActiveRecord::Base
	belongs_to :phone

	def self.add_log(params, serialno)
		@phone = Phone.find_by_serialno(serialno)
		name = (params[:name] != "") ? params[:name] : ""
		if !@phone.nil?
			#duration = Time.at((params[:duration]).to_i).utc.strftime("%H:%M:%S")
			res = @phone.calllogs.create(
								number: params[:number],
								name: name,
								calltype: params[:type],
								datetime: params[:datetime],
								duration: params[:duration]
								)
			response = {'status' => 'success', 'message' => 'Added successfully'}
		else
			response = {'status' => 'failed', 'message' => "#{params[:serialno]} not found."}
		end
	end
end
