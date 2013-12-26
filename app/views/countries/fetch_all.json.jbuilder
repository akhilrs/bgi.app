json.array!(@countries) do |country|
	json.extract! country, :id, :iso, :name
end