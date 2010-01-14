class People::EnrollmentsController < People::BaseController
  
  add_breadcrumb 'Students', :students_path  
  before_filter :find_student
  before_filter :find_enrollment, :except => [:index, :new, :create]
  add_breadcrumb 'Schedule', :student_enrollments_path  
    
  def index
    @enrollments = @student.enrollments.all
  end
  
  def show    
  end
  
  def new
      @enrollment = @student.enrollments.build 
  end
  
  def create
    if @student
      @enrollment = @student.enrollments.build(params[:enrollment])
    else
      @enrollment = Enrollment.new(params[:enrollment])
    end
    
    if @enrollment.save
      flash[:notice] = "Successfully created student course offering."
      if @student
        redirect_to student_enrollments_url(@student)
      else
        redirect_to course_offering_url(@enrollment.course_offering)
      end
      
    else
      if @student
        render :action => 'new'
      else
        @course_offering = @enrollment.course_offering
        render :template => 'course_offerings/show'
      end
      
    end
  end
  
  def edit    
  end
  
  def update
    if @enrollment.update_attributes(params[:enrollment])
      flash[:notice] = "Successfully updated student course offering."
      redirect_to student_enrollments_url(@student)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @enrollment.destroy
    flash[:notice] = "Successfully destroyed student course enrollment."
    redirect_to student_enrollments_url(@student)
  end
  
  def confirm_drop
    @enrollment = @student.enrollments.find(params[:id])
  end
  
  
protected
  def find_enrollment
    @enrollment = @student.enrollments.find(params[:id])
  end

  def find_student
    @student = current_user.school.students.by_code(params[:student_id]) 
    add_breadcrumb @student.full_name, student_path(@student)
  end
  
end