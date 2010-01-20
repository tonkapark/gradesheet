class Enrollment < ActiveRecord::Base

	belongs_to :student	
	belongs_to :course_term, :counter_cache => true
  has_many :assignment_evaluations, :dependent => :destroy
  has_many :assignments, :through => :course_term
  
	validates_existence_of	:student
  validates_existence_of	:course_term

	validates_uniqueness_of :student_id, :scope =>  :course_term_id
    
  def total_points_earned!
    self.total_points_earned = 0
    self.assignment_evaluations.each do |a|
     self.total_points_earned += a.points_earned_as_number
    end
    self.save!
  end  
   
end
