class AddCourseTermIdToEnrollments < ActiveRecord::Migration
  def self.up
    add_column :enrollments, :course_term_id, :string
    add_index :enrollments, :course_term_id
  end

  def self.down
    remove_column :enrollments, :course_term_id
  end
end
