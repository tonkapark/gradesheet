class People::StudentsController < People::BaseController

  before_filter :find_student, :except => [:index, :new, :create]
  
  def index  
  
    if params[:search]
      @students =current_user.school.students.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).ascend_by_lastname.paginate :page => params[:page]
    else
      @students = current_user.school.students.paginate :order => 'lastname', :page => params[:page]
    end
    
  end
  
  def show
  end
  
  def new
    @student = current_user.school.students.new    
  end
  
  def create
    @student = current_user.school.students.build(params[:student])    
    if @student.save
      flash[:notice] = "Successfully created student."
      redirect_to @student
    else
      render :action => 'new'
    end 
  end
  
  def edit
  end
  
  def update    
    if @student.update_attributes(params[:student])
      flash[:notice] = "Person  '" + @student.full_name + "'  was successfully updated."
      redirect_to @student
    else
      render :action => "edit"
    end    
  end
  
  def destroy
    @student.destroy
    flash[:notice] = "Person'" + @student.full_name + "'  was successfully deleted."
    redirect_to students_url
  end
  
protected
  def find_student
    @student = current_user.school.students.find(:first, :conditions => ["(id = ? or code = ?)", params[:id].to_i, params[:id]])
  end
    
end
