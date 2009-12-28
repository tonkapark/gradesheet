# This controller is used by the student/parent to access their grade information
class GradesController < GradesheetController

  before_filter :find_first_school_year_and_courses, :only => [:show, :index]
  
  def index        
  end
  
  def show        
    @course = Course.find(params[:id])
    @course.terms.sort!{|a,b| a.end_date <=> b.end_date}
  end

  def edit
    # We redirect edit so that we can re-use the courses side bar
    redirect_to :action => "show"
  end
  
protected
  def find_first_school_year_and_courses
    @school_year = SchoolYear.current.first
    @courses = current_user.courses.by_school_year(@school_year)
  end
  
end
