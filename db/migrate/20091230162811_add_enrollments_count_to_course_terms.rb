class AddEnrollmentsCountToCourseTerms < ActiveRecord::Migration
  def self.up
    add_column :course_terms, :enrollments_count, :integer, :default => 0
    CourseTerm.reset_column_information
    CourseTerm.find(:all).each do |p|
      CourseTerm.update_counters p.id, :enrollments_count => p.enrollments.length
    end
  end

  def self.down
    remove_column :course_terms, :enrollments_count
  end
end
