class AddTeacherIdToCourseTerm < ActiveRecord::Migration
  def self.up
    add_column :course_terms, :teacher_id, :integer
  end

  def self.down
    remove_column :course_terms, :teacher_id
  end
end
