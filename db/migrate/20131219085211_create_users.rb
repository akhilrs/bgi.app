class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.float :mobile
      t.text :address1
      t.text :address2
      t.string :state
      t.string :country
      t.integer :zipcode

      t.timestamps
    end
  end
end
