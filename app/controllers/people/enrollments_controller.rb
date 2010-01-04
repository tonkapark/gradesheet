class Users::EnrollmentsController < Users::BaseController
  
  before_filter :load_student
  
  def index
    @enrollments = @student.enrollments.all
  end
  
  def show
    @enrollment = @student.enrollments.find(params[:id])
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
    @enrollment = @student.enrollments.find(params[:id])
  end
  
  def update
    @enrollment = @student.enrollments.find(params[:id])
    if @enrollment.update_attributes(params[:enrollment])
      flash[:notice] = "Successfully updated student course offering."
      redirect_to student_enrollments_url(@student)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @enrollment = @student.enrollments.find(params[:id])
    @enrollment.destroy
    flash[:notice] = "Successfully destroyed student course offering."
    redirect_to student_enrollments_url(@student)
  end
  
  def confirm_drop
    @enrollment = @student.enrollments.find(params[:id])
  end
  
  
  protected
  def load_student
    @student = Student.find(params[:student_id]) 
  end
end