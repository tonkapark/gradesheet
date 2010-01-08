class Settings::BuildingsController < SettingsController

  before_filter :find_building, :except => [:index, :new, :create]
  before_filter :load_sites, :only => [:index, :new, :edit]

  def index
    @buildings = current_user.school.buildings.all
  end
  
  def show    
  end
  
  def new
    @building = current_user.school.buildings.new
    @building.rooms.build
  end
  
  def create
    @building = current_user.school.buildings.new(params[:building])
    if @building.save
      flash[:notice] = "Successfully created building."
      redirect_to buildings_url
    else
      render :action => 'new'
    end
  end
  
  def edit

  end
  
  def update

    if @building.update_attributes(params[:building])
      flash[:notice] = "Successfully updated building."
      redirect_to @building
    else
      render :action => 'edit'
    end
  end
  
  def destroy

    @building.destroy
    flash[:notice] = "Successfully destroyed building."
    redirect_to buildings_url
  end
  
protected 
  def find_building
    @building = current_user.school.buildings.find(params[:id])
  end
  
  def load_sites
    @sites = current_user.school.sites.find(:all)
  end
  
  
end
