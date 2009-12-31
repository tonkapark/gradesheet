# Contains the enrollment information for each course.
class Enrollment < ActiveRecord::Base
	belongs_to :student
	belongs_to :course
	belongs_to :course_term, :counter_cache => true
  has_many :assignment_evaluations
  
	validates_existence_of	:student
	validates_existence_of	:course
  validates_existence_of	:course_term

	validates_uniqueness_of :student_id, :scope =>  :course_term_id

end
