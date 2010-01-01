class AssignmentsController < GradesheetController

  before_filter :load_course_term, :only => [:new, :create]
  before_filter :load_assignment, :except => [:index, :new, :create]
  
  def index  
    @assignments = current_user.assignments.paginate :page => params[:page] unless current_user.type == 'Administrator'
    if current_user.type == 'Administrator' || current_user.is_admin?      
      @all_assignments = Assignment.paginate :page => params[:page]
    end    
  end
  
  def show
    AssignmentEvaluation.gradebook(@assignment.id).each do |sa|
      @assignment.assignment_evaluations.build(:enrollment_id => sa.enrollment_id) if sa.id.blank?
    end    
  end
  
    
  def new
    @assignment = @course_term.assignments.build
  end
  
  def create
    @assignment = @course_term.assignments.build(params[:assignment])
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
      redirect_to @assignment
    else
      render :action => 'show'
    end    
  end
  
  
protected
  def load_course_term
    @course_term = CourseTerm.find(params[:course_term_id])
  end
  
  def load_assignment
    @assignment = Assignment.find(params[:id])
  end
  
end
