class AddGradeToEnrollments < ActiveRecord::Migration
  def self.up
    add_column :enrollments, :grade, :string
  end

  def self.down
    remove_column :enrollments, :grade
  end
end
