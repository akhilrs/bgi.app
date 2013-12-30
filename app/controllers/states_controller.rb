class StatesController < ApplicationController
	def fetch_by_cid
		@country = Country.find_by iso: fetch_param.upcase
		countryid = @country.id
		@states = State.where("country_id = ?", countryid)
	end

	private

	def fetch_param
		params.require(:cid)
	end
end
