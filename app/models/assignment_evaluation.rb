# This model contains the evaluations for each assignment, by student.  It is
# the students "grade" for an assignment, if you will.
class AssignmentEvaluation < ActiveRecord::Base
  before_validation :massage_points_earned
  after_save :update_enrollment_points_earned
  
	belongs_to :enrollment
	belongs_to :assignment

	validates_existence_of :enrollment
	validates_existence_of :assignment
  validates_uniqueness_of :enrollment_id, :scope => :assignment_id
  # TODO: make sure there can only be one grade per student/assignment
  #	validates_uniqueness_of :student_id, :scope => [:assignment_id]
  #	validates_uniqueness_of :assignment_id, :scope => [:student_id]

	validates_numericality_of	:points_earned, :allow_nil => :true, :greater_than_or_equal_to => 0.0, :unless => :valid_points?, :message => 'must be 0 or greater, or (E)xcused or (M)issed.'

  # Calculate the points earned based on the presence of 'magic' characters
  def points_earned_as_number
    case self[:points_earned]
    when 'E'  # Excused assignment (grade is ignored)
      points = nil
    when 'M'  # Missing assignment (student gets no credit)
      points = 0.0
    else
      points = self[:points_earned]
    end
  
    return points.to_f
  end

  def points_desc
    case self[:points_earned]
    when 'E'
      description = 'Excused'
    when 'M'
      description = 'Missing'
    else
      description = ''
    end
    
    return description
  end
  
  
  def self.gradebook(assignment_id)
    find_by_sql ["
    SELECT
      sa.id,
      sco.id as enrollment_id
    FROM
      assignments a LEFT JOIN enrollments sco ON a.course_term_id = sco.course_term_id
      LEFT JOIN assignment_evaluations sa ON sco.id = sa.enrollment_id AND a.id = sa.assignment_id
    WHERE
      a.id = ?" , assignment_id]
  end  
  
protected
  
  def update_enrollment_points_earned
    self.enrollment.total_points_earned!
  end
      
  
private
  
	# There are certain 'magic' characters that can be substituted for a number
	# grade.  This method makes sure that the user only enters valid ones.
	#
	# * 'E' = Excused assignment (assignment is not counted)
	# * 'M' = Missing assignment (student gets no credit)
	def valid_points?
	  ['E', 'M'].include?(self.points_earned) ||
      (points_earned.is_a?(Numeric) && (points_earned.to_f == points_earned.to_f.abs))
	end

  def massage_points_earned
    self.points_earned = self.points_earned.to_f.abs  if points_earned.is_a?(Numeric)
    self.points_earned = self.points_earned.upcase    if points_earned.is_a?(String)
  end
  

  
end
