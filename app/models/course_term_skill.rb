# Links the course_term with supporting skills.
class CourseTermSkill < ActiveRecord::Base
  belongs_to :school
  belongs_to  :course_term
  belongs_to  :objective
  has_many    :objective_evaluations

  validates_associated    :course_term, :objective
  validates_uniqueness_of :course_term_id, :scope => :objective_id

  # Calculate a students current score for a particular course & term.
  def score(student_id)
    temp = self.objective_evaluations.first(:conditions => { :student_id => student_id})
    return temp.blank? ? "" : temp.score
  end

end
