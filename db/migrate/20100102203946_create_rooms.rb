class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.integer :building_id
      t.string :name
      t.integer :seats
      t.timestamps
    end
    
    add_index :rooms, :building_id
  end
  
  def self.down
    drop_table :rooms
  end
end
