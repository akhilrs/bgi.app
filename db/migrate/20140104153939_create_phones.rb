class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.belongs_to :user
      t.integer :number, :limit => 8
      t.string :model, :limit => 20
      t.string :make, :limit => 30
      t.string :imei, :limit => 17
      t.integer :primary, :limit => 1, :default => "1"
      t.timestamps
    end
  end
end
