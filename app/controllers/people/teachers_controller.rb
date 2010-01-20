class People::TeachersController < People::BaseController
  
  add_breadcrumb 'Teachers', :teachers_path  
  before_filter :find_teacher, :except => [:index, :new, :create]
  add_breadcrumb 'New', :new_teacher_path, :only => [:new, :create]
  add_breadcrumb 'Edit', :edit_teacher_path, :only => [:edit, :update] 
  
  def index  
  
    if params[:search]
      @teachers =current_user.school.teachers.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).ascend_by_lastname.paginate :page => params[:page]
    else
      @teachers = current_user.school.teachers.paginate :order => 'lastname', :page => params[:page]
    end
      
  end
  
  def show    
    
  end
  
  def new
    @teacher = current_user.school.teachers.new    
  end
  
  def create
    @teacher = current_user.school.teachers.build(params[:teacher])    
    if @teacher.save
      flash[:notice] = "Successfully created teacher."
      redirect_to @teacher
    else
      render :action => 'new'
    end 
  end
  
  def edit
  end
  
  def update    
    if @teacher.update_attributes(params[:teacher])
      flash[:notice] = "Person  '" + @teacher.full_name + "'  was successfully updated."
      redirect_to @teacher
    else
      render :action => "edit"
    end    
  end
  
  def destroy
    @teacher.destroy
    flash[:notice] = "Person'" + @teacher.full_name + "'  was successfully deleted."
    redirect_to teachers_url
  end
  
protected
  def find_teacher
    @teacher = current_user.school.teachers.by_code(params[:id])
    add_breadcrumb @teacher.full_name, :teacher_path
  end
  

end
