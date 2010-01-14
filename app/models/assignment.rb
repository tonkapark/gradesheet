# Contains the details about each assignment.
class Assignment < ActiveRecord::Base
  include Pacecar
  
  before_destroy :ensure_no_children
  
  belongs_to :school
  belongs_to	:course_term
  belongs_to	:assignment_category
  has_many		:assignment_evaluations
  has_many :enrollments, :through => :assignment_evaluations
  
  accepts_nested_attributes_for :assignment_evaluations, :allow_destroy => true, :reject_if => proc { |a| a['points_earned'].blank? }
  
  validates_length_of       :name, :within => 1..40
  validates_numericality_of :possible_points
  validates_presence_of     :possible_points
  validates_date            :due_date
  validates_existence_of    :course_term
  validates_existence_of    :assignment_category

  delegate :grading_scale, :to => :course_term  
  
  def self.timely
    self.due_date_inside(10.days.ago, Time.now + 10.days)
  end
  
  
  #will_paginate defaults
  cattr_reader :per_page
  @@per_page = 15      
  
  # Return a date formated for display as an assignment due date.
  def due_date_formatted
  	due_date.strftime("%A, %B %d, %Y")if due_date?
  end
  
  # Return a date
  def due_date_formatted=(due_at_str)
    # Is this still needed?
    self.due_date = Date.parse(due_at_str) if due_date?
  rescue ArgumentError
  	@due_date_invalid = true
  end
  
  # Validate assignment due dates
  def validate
    # Is this still needed?
  	errors.add(:due_date, "is invalid") if @due_date_invalid
  end

  def calculate_grade(student_id)
    possible_points = self.possible_points
    assignment = self.assignment_evaluations.select {|e| e.student_id == student_id}.first
    points_earned = assignment.blank? ? -1 : assignment.points_earned.to_f
    points_desc   = assignment.blank? ? '' : assignment.points_desc
    logger.debug  "  **** assignment: #{points_earned} out of #{possible_points}"

    # Sanitize the score & grade so that we don't try to divide by zero or anything stupid
    final_score   = possible_points > 0 ? ((points_earned/possible_points)*100).round(2) : -1
    letter_grade  = final_score > 0 ? self.grading_scale.calculate_letter_grade(final_score) : 'n/a'

    return {:letter => letter_grade, :score => final_score, :desc => points_desc }
  end
  
    
  
  private
  
  # We don't want the user to delete an assignment without first cleaning up
  # any grades that use it.  This could cause a cascading effect wiping out
  # a whole year of student data.	
  def ensure_no_children
  	unless self.assignment_evaluations.empty?
  		self.errors.add_to_base "You must remove all assignment evaluations before deleting."
  		raise ActiveRecord::Rollback
  	end
  end
  
end
