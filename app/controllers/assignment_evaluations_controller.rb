class AssignmentEvaluationsController < GradesheetController

  before_filter :load_assignment
  
  def index
    @evaluations = @assignment.assignment_evaluations.find(:all)
  end


  def show
    @evaluation = @assignment.assignment_evaluations.find(params[:id])
  end
  
  
protected
  def load_assignment
    @assignment = Assignment.find(params[:assignment_id])
  end
  
end
