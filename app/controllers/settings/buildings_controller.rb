class Settings::BuildingsController < SettingsController

  before_filter :find_building, :except => [:index, :new, :create]
  before_filter :load_sites, :only => [:new, :edit]

  def index
    @buildings = Building.all
  end
  
  def show    
  end
  
  def new
    @building = Building.new
    @building.rooms.build
  end
  
  def create
    @building = Building.new(params[:building])
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
    @building = Building.find(params[:id])
  end
  
  def load_sites
    @sites = Site.find(:all)
  end
  
  
end
