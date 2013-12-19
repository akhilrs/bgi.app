class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
    	t.string :iso, :limit => 2
    	t.string :name, :limit => 80
    end
  end
end
