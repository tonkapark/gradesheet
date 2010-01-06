class AddTeacherAssistantIdToCourseTerms < ActiveRecord::Migration
  def self.up
    add_column :course_terms, :teacher_assistant_id, :integer
  end

  def self.down
    remove_column :course_terms, :teacher_assistant_id
  end
end
