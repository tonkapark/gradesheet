class Settings::CatalogsController < SettingsController
  
  add_breadcrumb 'School Years', :catalogs_path
  before_filter :find_catalog, :only => [:edit, :update, :destroy]
  add_breadcrumb 'New', :new_catalog_path, :only => [:new, :create]
  add_breadcrumb 'Edit', :edit_catalog_path, :only => [:edit, :update]   
  
  def index
    @catalogs = current_user.school.catalogs.all(:order => "catalog_terms.ends_on DESC", :include => :catalog_terms)
  end

  def show
    @catalog = current_user.school.catalogs.find(params[:id], :include => :catalog_terms)
    add_breadcrumb @catalog.name, :catalog_path
  end


  def new
    @catalog = current_user.school.catalogs.new
  end


  def edit
  end


  def create
    @catalog = current_user.school.catalogs.new(params[:catalog])
    
    if @catalog.save
      flash[:notice] = "School catalog '#{@catalog.name}' was successfully created."
      redirect_to catalogs_path
    else
      flash[:error] = "Failed to create school catalog."
      render :action => "new"
    end
  end

  def update       
    if @catalog.update_attributes(params[:catalog])
      flash[:notice] = "School catalog '#{@catalog.name}' was successfully updated."
      redirect_to :action => :index 
    else
      render :action => "edit"
    end
  end


  def destroy
    if @catalog.destroy
      flash[:notice] = "School catalog '#{@catalog.name}' was successfully deleted."
    else
      flash[:error] = "School catalog '#{@catalog.name}' could not be deleted."
    end
    redirect_to :action => :index
  end

protected
  def find_catalog
    @catalog = current_user.school.catalogs.find(params[:id])
    add_breadcrumb @catalog.name, :catalog_path
  end
  
end
