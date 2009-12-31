class Settings::SchoolYearsController < SettingsController
  
  before_filter :find_year, :only => [:edit, :update, :destroy]
  after_filter :expire_cache, :only => [:create, :update, :destroy]  

  def index
    @years = SchoolYear.all(:order => "end_date DESC", :include => :terms)
  end

  def show
    @year = SchoolYear.find(params[:id], :include => :terms)
  end


  def new
    @year = SchoolYear.new
  end


  def edit
  end


  def create
    @year = SchoolYear.new(params[:school_year])

    if @year.save
      flash[:notice] = "School year '#{@year.name}' was successfully created."
      redirect_to school_years_path
    else
      flash[:error] = "Failed to create school year."
      render :action => "new"
    end
  end

  def update    
    if @year.update_attributes(params[:school_year])
      flash[:notice] = "School year '#{@year.name}' was successfully updated."
      redirect_to :action => :index 
    else
      render :action => "edit"
    end
  end


  def destroy
    if @year.destroy
      flash[:notice] = "School year '#{@year.name}' was successfully deleted."
    else
      flash[:error] = "School year '#{@year.name}' could not be deleted."
    end
    redirect_to :action => :index
  end

protected
  def find_year
    @year = SchoolYear.find(params[:id])
  end
  
private

  def expire_cache
    expire_fragment %r{course_list_*}   # Expire all the course caches
  end
end
