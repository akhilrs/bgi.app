class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
    	t.string :name, :limit => 80
    	t.integer :country_id
    	t.string :iso, :limit => 10
    end
  end
end
