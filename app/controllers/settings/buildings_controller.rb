class Settings::BuildingsController < SettingsController

  before_filter :load_sites, :only => [:new, :edit]

  def index
    @buildings = Building.all
  end
  
  def show
    @building = Building.find(params[:id])
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
    @building = Building.find(params[:id])
  end
  
  def update
    @building = Building.find(params[:id])
    if @building.update_attributes(params[:building])
      flash[:notice] = "Successfully updated building."
      redirect_to @building
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @building = Building.find(params[:id])
    @building.destroy
    flash[:notice] = "Successfully destroyed building."
    redirect_to buildings_url
  end
  
protected 
  def load_sites
    @sites = Site.find(:all)
  end
  
end
