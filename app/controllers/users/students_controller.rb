class Users::StudentsController < Users::BaseController

  before_filter :find_student, :only => [:edit, :update, :destroy ]
  before_filter :load_homerooms, :only => [:new, :edit, :create]
  before_filter :load_sites, :only => [:new, :edit]
  
  def index
    sort_init 'last_name'
    sort_update
    params[:sort_clause] = sort_clause
    @students = Student.search(params)

    respond_to do |format|
      format.html
      format.js { render :partial => "users/user_list", :locals => { :users => @students }}
    end
  end

  # We don't really want to show an individual person but rather the listing
  # of all people.
  def show
		redirect_to :action => :index
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
		## If an alternate HOMEROOM is provided then use it instead
		if !params[:homeroom1].empty?
			params[:student][:homeroom] = params[:homeroom1]
		end

    if @student.update_attributes(params[:student])
      flash[:notice] = "Student  '" + @student.full_name + "'  was successfully updated."
      redirect_to students_url
    else
      @homerooms = Student.find_homerooms()
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
    @student = Student.find(params[:id])
  end
  
  def load_homerooms
    @homerooms = Student.find_homerooms() 
  end
  
  def load_sites
    @sites = Site.find(:all)
  end
    
end
