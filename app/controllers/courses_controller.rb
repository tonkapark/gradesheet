class CoursesController < GradesheetController

  before_filter :find_course, :only => [:show, :edit, :update]
  before_filter :find_grade_scales, :only => [:edit, :new]
  after_filter :expire_cache, :only => [:create, :update, :destroy]

  def index
    @courses = current_user.school.courses.find(:all)
  end
  
  def new
    @course = current_user.school.courses.new
  end

  def edit        
    @skill_cats = current_user.school.supporting_skill_categories.active
  end

  def create
    @course  = current_user.school.courses.new(params[:course])        

    if @course.save
      flash[:notice] = "Course '#{@course.name}' was successfully created."
      redirect_to(courses_url)
    else
      find_grade_scales
      render :action => "new"
    end
   
  end

  def update
    if @course.update_attributes(params[:course])
      flash[:notice] = "Successfully updated course."
      redirect_to @course
    else
      render :action => 'edit'
    end
  end


  def destroy  
    @course.destroy
    flash[:notice] = "Course '#{@course.name}' was successfully deleted."
    redirect_to courses_url
  end


protected
  def find_course
    @course = current_user.school.courses.find(params[:id])
  end
  
  def find_grade_scales
    @grading_scales = current_user.school.grading_scales.find(:all)
  end
    
  private

  def expire_cache
    # Expire this users cache
    # OPTIMIZE: The way I understand it, manually coding these expires is more
    #           efficient than using a RegEx.
    expire_fragment "course_list_#{current_user.id}_assignments"
    expire_fragment "course_list_#{current_user.id}_evaluations"
  end
end
