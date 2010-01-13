# Links the course with each of its terms or grading periods.
class CourseTerm < ActiveRecord::Base
	
  attr_accessible :school, :course_id, :code, :grading_scale_id, :term_id, :enrollments_count, :teacher_id, :enrollments_attributes, :room_id, :seats
  
  belongs_to :school
  belongs_to :teacher
  belongs_to  :term
	belongs_to  :course
  belongs_to :room
  belongs_to  :grading_scale
  
  has_many    :course_term_skills
  has_many    :supporting_skills,       :through => :course_term_skills
  has_many    :assignments
	has_many    :assignment_evaluations,  :through => :assignments  
  has_many    :comments, :as => :commentable
  
  has_many :enrollments
  accepts_nested_attributes_for :enrollments
  
	validates_existence_of	:term
	validates_existence_of	:course
  validates_existence_of	:teacher
	validates_existence_of :grading_scale
  
  before_save :upcase_code
  validates_length_of :code, :in => 3..35
  validates_format_of :code, :with => /^[\w\/\-\.]+$/,
                              :message => "cannot contain certain special characters or spaces. Valid(a-z, 0-9, / . -)"
  validates_uniqueness_of :code ,:scope => [:school, :course, :term]
  validates_numericality_of :seats, :greater_than => 0
  validate :student_limit

  delegate :school_year,    :to => :term
  delegate :active,         :to => :term  
  delegate :students,       :to => :enrollment
  
  # Sections are considered 'active' only if they are in a grading term that is 'active'.
  named_scope :active, :include => :terms,
    :conditions	=> ["date_ranges.active = ?", true],
    :order => ["courses.name ASC"]

  # Find all the sections for a particular school year
  named_scope :by_school_year, lambda { |*school_year| 
    { :include => :terms,
      :conditions => ["date_ranges.school_year_id = ?", school_year ||= SchoolYear.current]
    }
  }  
  
  #will_paginate defaults
  cattr_reader :per_page
  @@per_page = 15  
  
  # Calculate a students current grade for a particular course & term.
  def calculate_grade(student_id)
    # Set up some variables
    points_earned       = 0.0
    possible_points     = 0.0

    # Loop through the assignments for computing the grade as we go
    self.assignment_evaluations.all(:conditions => { :student_id => student_id}).each do |evaluation|
      valid_points = evaluation.points_earned_as_number
      if valid_points
        points_earned += valid_points.to_f
        possible_points += evaluation.assignment.possible_points.to_f
      end
      logger.debug " **** points earned: #{valid_points} out of #{evaluation.assignment.possible_points}"
    end

    logger.debug  " **** final! #{points_earned} out of #{possible_points}"
    # Sanitize the score & grade so that we don't try to divide by zero or anything stupid
    final_score = possible_points > 0 ? ((points_earned/possible_points)*100).round(2) : -1
    letter_grade = final_score > 0 ? self.course.grading_scale.calculate_letter_grade(final_score) : 'n/a'

    return {:letter => letter_grade, :score => final_score }
  end

  # Retrieve comments for a student in this course term
  def comments(student_id)
    comment = Comment.find_by_user_id_and_commentable_id(student_id, self.id.to_s)
    return comment ? comment.content : ''
  end
  
  def total_possible_points
    total_possible_points = 0
    self.assignments.each do |a|
     total_possible_points += a.possible_points
   end
   return total_possible_points
  end   


  
protected

  def student_limit
    unless self.room.blank?
      errors.add_to_base("Course section seat count must be equal to or less than the selected room's seat count")  unless self.room.seats >= self.seats
    end
  end

  def upcase_code
    self.code = code.to_s.upcase
  end
  
end
