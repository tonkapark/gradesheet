class Settings::RoomsController < SettingsController
  before_filter :load_building
  
  def index
    @rooms = @building.rooms.all
  end
  
  def show
    @room = @building.rooms.find(params[:id])
  end
  
  def new
    @room = @building.rooms.build
  end
  
  def create
    @room = @building.rooms.build(params[:room])
    if @room.save
      flash[:notice] = "Successfully created room."
      redirect_to buildings_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @room = @building.rooms.find(params[:id])
  end
  
  def update
    @room = @building.rooms.find(params[:id])
    if @room.update_attributes(params[:room])
      flash[:notice] = "Successfully updated room."
      redirect_to buildings_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @room = @building.rooms.find(params[:id])
    @room.destroy
    flash[:notice] = "Successfully destroyed room."
    redirect_to rooms_url
  end
  
  
  protected
  def load_building
    @building = Building.find(params[:building_id])
  end
end
