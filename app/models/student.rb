class Student < PersonRole
	has_many	:enrollments
  has_many	:course_terms, :through => :enrollments
	has_many	:assignment_evaluations
  has_many :assignments, :through => :assignment_evaluations
  has_many :supporting_skill_evaluations
  has_many :course_term_skills,  :through => :supporting_skill_evaluations

  has_one    :comment, :as => :commentable

  def current_course_terms
    return CourseTerm.all(:joins => :course)
  end
  
  def self.available_for_course_term(course_term)
    find_by_sql ["
        SELECT
          pr.* 
        FROM
          person_roles pr
        WHERE
          pr.type = 'Student'
          and
          pr.person_id not in (
                      SELECT
                        sco.student_id 
                      FROM
                        enrollments sco
                      WHERE 
                        sco.course_term_id = ?);
            ", course_term.id]
  end
  
end
