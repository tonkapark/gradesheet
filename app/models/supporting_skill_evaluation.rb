class SupportingSkillEvaluation < ActiveRecord::Base
  belongs_to :school
  belongs_to  :student
  belongs_to  :course_term_skill
end
