# Stores the different types of assigments (Quiz, Test, Homework, etc.) as a
# lookup table.
class AssignmentCategory < ActiveRecord::Base
	belongs_to :school
  has_many	:assignments
	
  validates_presence_of :school_id
	validates_size_of        :name, :within => 1..30
  validates_uniqueness_of  :name, :case_sensitive => false

end
