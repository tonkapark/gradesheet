class DropTableSupportSkillCodes < ActiveRecord::Migration
  def self.up
    drop_table :supporting_skill_codes
  end

  def self.down
    create_table :supporting_skill_codes do |t|
      t.integer :supporting_skill_id
      t.string  :code
      t.string  :description
      t.boolean :active

      t.timestamps
    end    
  end
end
