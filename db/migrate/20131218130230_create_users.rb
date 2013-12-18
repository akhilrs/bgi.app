class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :passowrd
      t.string :salt
      t.float :mobile, :limit => 12

      t.timestamps
    end
  end
end
