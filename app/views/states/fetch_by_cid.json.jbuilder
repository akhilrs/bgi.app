json.array!(@states) do |state|
	json.extract! state, :id, :country_id, :iso, :name
end