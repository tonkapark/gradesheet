class Settings::AssignmentCategoriesController < SettingsController

  before_filter :find_type, :only => [:show, :edit, :update, :destroy]

  def index
    @types = AssignmentCategory.all
    
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
    @type = AssignmentCategory.new

    render :action => :edit
  end


  def edit
  end


  def create
    @type = AssignmentCategory.new(params[:assignment_category])

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
    @type = AssignmentCategory.find(params[:id])
  end
  
end
