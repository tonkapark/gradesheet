# Contains the information about each course for each teacher.
class Course < ActiveRecord::Base
  
  attr_accessible :name, :code, :grading_scale_id, :school
  
  before_save :upcase_code
  before_destroy 	:ensure_no_children
  
  belongs_to	:school
  belongs_to  :grading_scale
  
  has_many		:enrollments
  has_many    :course_terms
  has_many    :terms,     :through => :course_terms
  has_many		:students,  :through => :enrollments

  validates_presence_of :code, :name, :school_id
  validates_existence_of :grading_scale
  
  validates_length_of		:name, :in => 1..100
  
  #will_paginate defaults
  cattr_reader :per_page
  @@per_page = 5     
  
  # Courses are considered 'active' only if they are in a grading term that is 'active'.
  named_scope :active, :include => :terms,
    :conditions	=> ["date_ranges.active = ?", true],
    :order => ["courses.name ASC"]

  # Find all the courses for a particular school year
  named_scope :by_school_year, lambda { |*school_year| 
    { :include => :terms,
      :conditions => ["date_ranges.school_year_id = ?", school_year ||= SchoolYear.current]
    }
  }

  # Calculate the school year for this course
  def school_year
    return self.terms.first.school_year
  end
  
  
protected
  def upcase_code
    self.code = code.to_s.upcase
  end
  
private
  
  # Ensure that the user does not delete a record without first cleaning up
  # any records that use it.  This could cause a cascading effect, wiping out
  # more data than expected.
  # FIXME
  def ensure_no_children
    #		unless self.assignments.empty?
    #			self.errors.add_to_base "You must remove all Assignments before deleting."
    #			raise ActiveRecord::Rollback
    #		end
  end
  
end
