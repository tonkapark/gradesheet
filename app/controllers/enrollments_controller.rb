class EnrollmentsController < GradesheetController

  def create
    @enrollment = Enrollment.new(params[:enrollment])
    
    if @enrollment.save
      flash[:notice] = "Successfully created student course enrollment."
      redirect_to course_term_url(@enrollment.course_term)
    else
      @course_term = @enrollment.course_term
      render :template => 'course_terms/show'
    end
  end
  

end
