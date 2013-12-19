class LoadCountries < ActiveRecord::Migration
  def change
  	require File.expand_path('../../seed/state_country_seeds.rb', __FILE__)
  end
end
