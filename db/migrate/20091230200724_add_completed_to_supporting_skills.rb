class AddCompletedToSupportingSkills < ActiveRecord::Migration
  def self.up
    add_column :supporting_skills, :completed, :boolean, :default => false
  end

  def self.down
    remove_column :supporting_skills, :completed
  end
end
