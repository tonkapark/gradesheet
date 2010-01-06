class People::StudentsController < People::BaseController

  before_filter :find_student, :only => [:show, :edit, :update, :destroy ]

  def index
    sort_init 'lastname'
    sort_update
    params[:sort_clause] = sort_clause
        
    if params[:search]
      @students = Student.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).paginate  :order => params[:sort_clause], :page => params[:page]
    else
      @students = Student.paginate :order => params[:sort_clause], :page => params[:page]
    end        

    respond_to do |format|
      format.html
      format.js { render :partial => "people/user_list", :locals => { :people => @students }}
    end
  end

  def show
		
  end

  def new
    @student = Student.new
  end

  def edit       
  end

  def create
    @student = Student.new(params[:student])
    
    respond_to do |format|
      if @student.save
        flash[:notice] = 'Student was successfully created.'
        format.html { redirect_to(@student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update    

    if @student.update_attributes(params[:student])
      flash[:notice] = "Student  '" + @student.full_name + "'  was successfully updated."
      redirect_to @student
    else
      render :action => "edit"
    end
  end
  
  def destroy    
    if @student.destroy
      flash[:notice] = "Student  '" + @student.full_name + "'  was successfully deleted."
      redirect_to :action => :index
    end
  end
  
protected
  def find_student
    @student = Student.find_by_code!(params[:id])
  end
    
end
