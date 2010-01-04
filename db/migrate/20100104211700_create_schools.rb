class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name
      t.timestamps
    end
    
    School.create(:id => 1, :name => 'Default School')
  end

  def self.down
    drop_table :schools
  end
end
