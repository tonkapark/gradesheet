class RemoveColumnTeacherIdFromCourses < ActiveRecord::Migration
  def self.up
    remove_column  :courses, :teacher_id
  end

  def self.down
    add_column :courses, :teacher_id, :integer    
  end
end
