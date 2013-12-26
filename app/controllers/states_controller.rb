class StatesController < ApplicationController
	def fetch_by_cid
		@states = State.where("country_id = ?", fetch_param)
	end

	private

	def fetch_param
		params.require(:cid)
	end
end
