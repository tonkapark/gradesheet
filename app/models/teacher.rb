# Subclass of User that handles the Teacher users
class Teacher < User
	has_many :course_terms
	has_many :assignments, :through => :course_terms
end
