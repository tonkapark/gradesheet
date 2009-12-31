class CourseTermsController < GradesheetController
   
  def index
    @course_terms = CourseTerm.paginate :page => params[:page]
  end
  
  def show
    @course_term = CourseTerm.find(params[:id])
  end
  
  def new
    @course_term = CourseTerm.new
    @course_term.course_id = params[:course_id]
  end
  
  def create
    @course_term = CourseTerm.new(params[:course_term])
    if @course_term.save
      flash[:notice] = "Successfully created course offering."
      redirect_to @course_term
    else
      render :action => 'new'
    end
  end
  
  def edit
    @course_term = CourseTerm.find(params[:id])
  end
  
  def update
    @course_term = CourseTerm.find(params[:id])
    if @course_term.update_attributes(params[:course_term])
      flash[:notice] = "Successfully updated course offering."
      redirect_to @course_term
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @course_term = CourseTerm.find(params[:id])
    @course_term.destroy
    flash[:notice] = "Successfully destroyed course offering."
    redirect_to course_terms_url
  end

  def grades
    @course_term = CourseTerm.find(params[:id])
  end
  
end
