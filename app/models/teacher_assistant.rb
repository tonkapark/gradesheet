# Subclass of User that handles the TeacherAssistant users
class TeacherAssistant < User
	has_many :course_terms
	has_many :assignments, :through => :course_terms  
end
