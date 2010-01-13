# Contains the information about each course for each teacher.
class Course < ActiveRecord::Base
  
  attr_accessible :name, :code, :school
  
  before_save :upcase_code
  before_destroy 	:ensure_no_children
  
  belongs_to	:school  
  
  has_many		:enrollments
  has_many    :course_terms
  has_many    :terms,     :through => :course_terms
  has_many		:students,  :through => :enrollments

  validates_presence_of :code, :name, :school_id    
  validates_length_of		:name, :in => 1..100
  
  #will_paginate defaults
  cattr_reader :per_page
  @@per_page = 15     
  
  
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
