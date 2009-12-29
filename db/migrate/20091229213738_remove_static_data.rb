class RemoveStaticData < ActiveRecord::Migration
  def self.up
    drop_table :static_data
  end

  def self.down
    create_table :static_data do |t|
      t.string  :name
      t.string  :value

      t.timestamps
    end
  end
end
