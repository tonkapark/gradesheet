class AddSeatsToCourseTerms < ActiveRecord::Migration
  def self.up
    add_column :course_terms, :seats, :integer
  end

  def self.down
    remove_column :course_terms, :seats
  end
end
