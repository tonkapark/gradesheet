class AssignmentsController < GradesheetController
  
  add_breadcrumb 'Course Sections', :course_terms_path  
  add_breadcrumb 'Assignments', :assignments_path
  before_filter :load_course_term, :only => [:new, :create]
  before_filter :load_assignment, :except => [:index, :new, :create]
  add_breadcrumb 'New', :new_course_term_assignment_path, :only => [:new, :create]
  add_breadcrumb 'Edit', :edit_assignment_path, :only => [:edit, :update]       
  
  def index  
    @assignments = current_user.person.assignments.by_due_date.paginate :page => params[:page] unless current_user.person.class.name == 'Administrator'
    
    if current_user.admin?      
      @all_assignments = current_user.school.assignments.by_due_date.paginate :page => params[:page]
    end    
  end
  
  def show
    current_user.school.assignment_evaluations.gradebook(@assignment.id).each do |sa|
      @assignment.assignment_evaluations.build(:enrollment_id => sa.enrollment_id, :school_id => current_user.school.id) if sa.id.blank?
    end    
  end
  
    
  def new
    @assignment = @course_term.assignments.build
  end
  
  def create
    @assignment = @course_term.assignments.build(params[:assignment])
    @assignment.school = current_user.school    
    if @assignment.save
      flash[:notice] = "Successfully created assignment."
      redirect_to @course_term
    else
      render :action => 'new'
    end
  end
  
  def edit
    @course_term = @assignment.course_term
  end
  
  def update
    @assignment.school = current_user.school
    if @assignment.update_attributes(params[:assignment])
      flash[:notice] = "Successfully updated assignment."
      redirect_to @assignment.course_term
    else
      render :action => 'edit'
    end
  end
  
  def destroy    
    @assignment.destroy
    flash[:notice] = "Successfully destroyed assignment."
    redirect_to course_term_url(@course_term)
  end
  
  def evaluate
    if @assignment.update_attributes(params[:assignment])
      flash[:notice] = "Successfully posted assignment results."
      redirect_to @assignment.course_term
    else
      render :action => 'show'
    end    
  end
  
  
protected
  def load_course_term
    @course_term = current_user.school.course_terms.find(params[:course_term_id])
    add_breadcrumb @course_term.code, course_term_path(@course_term)
  end
  
  def load_assignment
    @assignment = current_user.school.assignments.find(params[:id])
    add_breadcrumb @assignment.course_term.code, :course_term_path
    add_breadcrumb @assignment.name, :assignment_path
  end
  
end
