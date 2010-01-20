class People::AssignmentEvaluationsController < People::BaseController
  
  
  before_filter :find_student_and_enrollment, :only => [:index]
  
  def index
    @assignment_evaluations = @enrollment.assignment_evaluations.all
  end
    
  protected
  def find_student_and_enrollment
    @student = current_user.school.students.by_code(params[:student_id])
    @enrollment = @student.enrollments.find(params[:enrollment_id])    
    add_breadcrumb 'Students', :students_path  
    add_breadcrumb @student.full_name, student_path(@student)
    add_breadcrumb 'Schedule', :student_enrollments_path
    add_breadcrumb @enrollment.course_term.code, nil    
    add_breadcrumb 'Assignments', :sco_assignment_evaluations_path 
  end
end
