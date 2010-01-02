class CourseTermsController < GradesheetController
   
   before_filter :find_course_term, :except => [:index, :new, :create]
   
  def index    
    @course_terms = current_user.course_terms.paginate :page => params[:page] unless current_user.type == 'Administrator'
    
    if current_user.type == 'Administrator' || current_user.is_admin?
      @all_course_terms = CourseTerm.paginate :page => params[:page]
    end    
  end
  
  def show
    
  end
  
  def new
    @course_term = CourseTerm.new
    @course_term.course_id = params[:course_id] #if params [:course_id]
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
    
  end
  
  def update
    
    if @course_term.update_attributes(params[:course_term])
      flash[:notice] = "Successfully updated course offering."
      redirect_to @course_term
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    
    @course_term.destroy
    flash[:notice] = "Successfully destroyed course offering."
    redirect_to course_terms_url
  end

  def grades
    
  end
  
  def post_grades
    
    if @course_term.update_attributes(params[:course_term])
      flash[:notice] = "Successfully posted grades."
      redirect_to grades_course_term_path(@course_term)
    else
      render :action => 'grades'
    end
  end  
  
protected
  def find_course_term
    @course_term = CourseTerm.find(params[:id])
  end
end
