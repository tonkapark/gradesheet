# Subclass of User that handles the Student users
class Student < Person  
	has_many	:enrollments
  has_many	:course_terms, :through => :enrollments
	has_many	:assignment_evaluations
  has_many :assignments, :through => :assignment_evaluations
  has_many :supporting_skill_evaluations
  has_many :course_term_skills,  :through => :supporting_skill_evaluations

  has_one    :comment, :as => :commentable

	#validates_length_of	:homeroom, :maximum => 20
	#validate :is_not_admin
  
	#~ from_year = Time.now.year - 1
	#~ to_year = from_year + 12
	#~ validates_inclusion_of :class_of, 
    #~ :in => from_year..to_year,
    #~ :message => "must be in the range of #{from_year} to #{to_year}"

  def current_course_terms
    return CourseTerm.all(:joins => :course)
  end

  # Return an array of unique homerooms that are in the system.
	#~ def self.find_homerooms(*args)
    #~ # FIXME: This should probably just return homerooms that are being used by 'valid' students
		#~ return Student.all(:select => 'homeroom', :group => 'homeroom', 
      #~ :conditions => "homeroom > ''", :order => "homeroom").map { |h| h.homeroom }
	#~ end

  #~ def self.find_classes_of
    #~ return Student.all(
      #~ :select     => "class_of",
      #~ :group      => "class_of",
      #~ :conditions => "class_of is not null",
      #~ :order      => "class_of"
      #~ )
    #~ end
    
    
  
  def self.available_for_course_term(course_term)
    find_by_sql ["
        SELECT
          * 
        FROM
          people s 
        WHERE
          s.type = 'Student'
          and
          s.id not in (
                      SELECT
                        sco.student_id 
                      FROM
                        enrollments sco
                      WHERE 
                        sco.course_term_id = ?);
            ", course_term.id]
  end
  
  

end
