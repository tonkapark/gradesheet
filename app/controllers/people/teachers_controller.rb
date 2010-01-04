class Users::TeachersController < Users::BaseController
  
  before_filter :find_teacher, :only => [:show, :edit, :update, :destroy]
  
  
  def index
    sort_init 'last_name'
    sort_update
    params[:sort_clause] = sort_clause
    @teachers = Teacher.search(params)

    respond_to do |format|
      format.html
      format.js { render :partial => "users/user_list", :locals => { :users => @teachers } }
    end
  end

  def show

  end

  def new
    @teacher = Teacher.new
  end

  def edit
  end

  def create
    @teacher = Teacher.new(params[:teacher])

    respond_to do |format|
      if @teacher.save
        flash[:notice] = "Teacher #{@teacher.full_name}' was successfully created."
        format.html { redirect_to(teachers_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        flash[:notice] = "Teacher '#{@teacher.full_name}' was successfully updated."
        format.html { redirect_to(teachers_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to(teachers_url) }
      format.xml  { head :ok }
    end
  end
  
protected
  def find_teacher
    @teacher = Teacher.find(params[:id])
  end  
  

end
