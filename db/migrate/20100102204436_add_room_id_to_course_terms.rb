class AddRoomIdToCourseTerms < ActiveRecord::Migration
  def self.up
    add_column :course_terms, :room_id, :integer
    add_index :course_terms, :room_id
  end

  def self.down
    remove_column :course_terms, :room_id
  end
end
