class CoursesController < GradesheetController

  add_breadcrumb 'Courses', :courses_path  
  before_filter :find_course, :only => [:show, :edit, :update]    
  add_breadcrumb 'New', :new_course_path, :only => [:new, :create]
  add_breadcrumb 'Edit', :edit_course_path, :only => [:edit, :update]  

  def index
    @courses = current_user.school.courses.paginate :page => params[:page]
  end
  
  def new
    @course = current_user.school.courses.new
  end

  def edit            
  end

  def create
    @course  = current_user.school.courses.new(params[:course])        

    if @course.save
      flash[:notice] = "Course '#{@course.name}' was successfully created."
      redirect_to(courses_url)
    else      
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
    add_breadcrumb @course.code, :course_path
  end
      
end
