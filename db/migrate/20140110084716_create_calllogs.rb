class CreateCalllogs < ActiveRecord::Migration
  def change
    create_table :calllogs do |t|
    	t.belongs_to :phone
      	t.string :number, :limit => 13
      	t.string :name, :limit => 50
      	t.string :calltype, :limit => 10
      	t.datetime :datetime
      	t.time :duration
      t.timestamps
    end
  end
end
