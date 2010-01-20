class CourseTermsController < GradesheetController
   
   add_breadcrumb 'Courses Sections', :course_terms_path
   before_filter :find_course_term, :except => [:index, :new, :create]
   before_filter :find_grade_scales, :only => [:edit, :new]
  add_breadcrumb 'New', :new_course_term_path, :only => [:new, :create]
  add_breadcrumb 'Edit', :edit_course_term_path, :only => [:edit, :update]     
   
  def index    
    @course_terms = current_user.person.course_terms.paginate :page => params[:page] unless current_user.admin?
    
    if current_user.admin?
      @all_course_terms = current_user.school.course_terms.paginate :page => params[:page]
    end    
  end
  
  def show
    @assignment_months = @course_term.assignments.month_group
  end
  
  def new
    @course_term = current_user.school.course_terms.new
    @course_term.course_id = params[:course_id] #if params [:course_id]
  end
  
  def create
    @course_term = current_user.school.course_terms.new(params[:course_term])
    if @course_term.save
      flash[:notice] = "Successfully created course offering."
      redirect_to @course_term
    else
      find_grade_scales
      render :action => 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
    respond_to do |wants|
      if @course_term.update_attributes(params[:course_term])
        wants.html {
        flash[:notice] = "Successfully updated course offering."
        redirect_to @course_term
        }
      else
        wants.html { render :action => 'edit' }
   end
    end
  end
  
  def destroy
    
    @course_term.destroy
    flash[:notice] = "Successfully destroyed course offering."
    redirect_to course_terms_url
  end

  def grades
    add_breadcrumb 'Gradebook', :grades_course_term_path
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
    @course_term = current_user.school.course_terms.find(params[:id])
    add_breadcrumb @course_term.code, :course_term_path
  end
  
  def find_grade_scales
    @grading_scales = current_user.school.grading_scales.find(:all)
  end  

end
