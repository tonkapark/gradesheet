class AssignmentsController < GradesheetController
  
  before_filter :find_assigment, :only => [:edit, :update, :destroy]
  
  def show
    @course_term = CourseTerm.find(params[:id])
    @assignments = @course_term.assignments.sort{|a,b| a.due_date <=> b.due_date}.reverse

	  respond_to do |format|
			format.html
	    format.js		{ render :partial => "assignment_list" }	# Render the list of assignments for a course
	  end
  end


  def new
    @assignment = Assignment.new
    @course_term = CourseTerm.find(params[:course_term_id])

    render :action => :edit
  end


  def edit    
	  @course_term = CourseTerm.find(@assignment.course_term_id)
  end


  def create
    @assignment = Assignment.new(params[:assignment])

    if @assignment.save
      flash[:notice] = "Assignment '#{@assignment.name}' was created successfully."
      if params["evaluations"]
        redirect_to :action => "show", :id => @assignment.course_term.id, :controller => "evaluations"
      else
        redirect_to :action => "show", :id => @assignment.course_term.id
      end
    else
      @course_term = CourseTerm.find(@assignment.course_term_id)
      render :action => "edit"
    end
  end

  def update

    if @assignment.update_attributes(params[:assignment])
      flash[:notice] = "Assignment '#{@assignment.name}' was updated successfully."
      if params["evaluations"]
        redirect_to :action => "show", :id => @assignment.course_term.id, :controller => "evaluations"
      else
        redirect_to :action => "show", :id => @assignment.course_term.id
      end
    else
      @course_term = CourseTerm.find(params[:assignment][:course_term_id])
      render :action => "edit"
    end
  end

  def destroy
    
    if @assignment.destroy
      flash[:notice] = "Assignment '#{@assignment.name}' was deleted successfully."
    else
      flash[:error] = "Assignment '#{@assignment.name}' was not deleted successfully.
                        Are there assigned grades?"
    end
    
    respond_to do |format|
      format.html { redirect_to :action => 'show', :id => @assignment.course_term.id }
    end
  end
  
protected
  def find_assignment
    @assignment = Assignment.find(params[:id])
  end
  
end
