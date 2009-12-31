class AddCodeToCourseTerms < ActiveRecord::Migration
  def self.up
    add_column :course_terms, :code, :string
    add_index :course_terms, :code
  end

  def self.down
    remove_column :course_terms, :code
  end
end
