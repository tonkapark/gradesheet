class CreateBuildings < ActiveRecord::Migration
  def self.up
    create_table :buildings do |t|
      t.integer :site_id
      t.string :name
      t.integer :rooms_count
      t.timestamps
    end
    
    add_index :buildings, :site_id
  end
  
  def self.down
    drop_table :buildings
  end
end
