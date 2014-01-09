class CreateCallLogs < ActiveRecord::Migration
  def change
    create_table :call_logs do |t|
      t.belongs_to :phone
      t.integer :number, :limit => 8
      t.string :name, :limit => 50,
      t.string :type, :limit => 10, :default => 'incoming'
      t.datetime :datetime
      t.time :duration
      
      t.timestamps
    end
  end
end
