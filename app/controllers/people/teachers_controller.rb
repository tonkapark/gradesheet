class People::TeachersController < People::BaseController
  
  before_filter :find_teacher, :only => [:show, :edit, :update, :destroy]
  
  
  def index
    sort_init 'lastname'
    sort_update
    params[:sort_clause] = sort_clause

    if params[:search]
      @teachers = Teacher.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).paginate  :order => params[:sort_clause], :page => params[:page]
    else
      @teachers = Teacher.paginate :order => params[:sort_clause], :page => params[:page]
    end        
    
    respond_to do |format|
      format.html
      format.js { render :partial => "people/user_list", :locals => { :people => @teachers } }
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
        format.html { redirect_to(@teacher) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        flash[:notice] = "Teacher '#{@teacher.full_name}' was successfully updated."
        format.html { redirect_to(@teacher) }
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
    @teacher = Teacher.find_by_code!(params[:id])
  end  
  

end
