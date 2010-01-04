class Users::AssignmentEvaluationsController < Users::BaseController
  
  before_filter :load_student_and_course_term, :only => [:index]
  
  def index
    @assignment_evaluations = @enrollment.assignment_evaluations.all
  end
    
  protected
  def load_student_and_course_term
    @enrollment = Enrollment.find(params[:enrollment_id])
    @student = Student.find(params[:student_id])
  end
end
