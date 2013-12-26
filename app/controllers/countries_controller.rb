class CountriesController < ApplicationController

	#before_action :fetch_country, only: [:fetch]
	def fetch
		@country = Country.find_by iso: fetch_param.upcase
	end

	def fetch_all
		@countries = Country.all
	end

	private

	def fetch_param
		params.require(:iso)
	end
end
