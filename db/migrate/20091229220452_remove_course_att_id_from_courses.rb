class RemoveCourseAttIdFromCourses < ActiveRecord::Migration
  def self.up
    remove_column  :courses, :course_att_id
  end

  def self.down
    add_column  :courses, :course_att_id, :integer
  end
end
