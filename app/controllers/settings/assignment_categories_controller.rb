class Settings::AssignmentCategoriesController < SettingsController

  before_filter :find_type, :only => [:show, :edit, :update, :destroy]

  def index
    @types = current_user.school.assignment_categories.all
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end


  def new
    @type = current_user.school.assignment_categories.new
    
    render :action => :edit
  end


  def edit
  end


  def create
    @type = current_user.school.assignment_categories.new(params[:assignment_category])
    #@type.school = current_user.school
    respond_to do |format|
      if @type.save
        flash[:notice] = "Assignment type '#{@type.name}' was successfully created."
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => :edit  }
      end
    end
  end

  def update

    respond_to do |format|
      if @type.update_attributes(params[:assignment_category])
        flash[:notice] = "Assignment type '#{@type.name}' was successfully updated."
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy    
    @type.destroy

    respond_to do |format|
      flash[:notice] = "Assignment type '#{@type.name}' was successfully deleted."
      format.html { redirect_to(assignment_categories_url) }
    end
  end
  
protected
  def find_type
    @type = current_user.school.assignment_categories.find(params[:id])
  end
  
end
