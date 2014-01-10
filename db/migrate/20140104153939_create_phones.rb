class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.belongs_to :user
      t.string :number, :limit => 13
      t.string :model, :limit => 20
      t.string :make, :limit => 30
      t.string :imei, :limit => 17
      t.string :serialno, :limit =>  30
      t.integer :primary, :limit => 1, :default => "1"
      t.timestamps
    end
  end
end
