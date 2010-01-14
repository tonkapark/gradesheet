class Settings::RoomsController < SettingsController
  
  add_breadcrumb 'Buildings', :buildings_path  
  before_filter :load_building, :only => [:index, :new, :create]
  before_filter :find_room_and_building, :except => [:index, :new, :create]  
  
  add_breadcrumb 'New', :new_building_room_path, :only => [:new, :create]
  add_breadcrumb 'Edit', :edit_building_room_path, :only => [:edit, :update]   
  
  
  def index
    @rooms = @building.rooms.all
  end
  
  def show
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

  end
  
  def update

    if @room.update_attributes(params[:room])
      flash[:notice] = "Successfully updated room."
      redirect_to buildings_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy    
    @room.destroy
    flash[:notice] = "Successfully destroyed room."
    redirect_to rooms_url
  end
  
  
  protected
  def find_room_and_building
    load_building
    add_breadcrumb 'Rooms', :building_rooms_path
    @room = @building.rooms.find(params[:id])
    add_breadcrumb @room.name, :building_room_path
  end
  
  def load_building
    @building = current_user.school.buildings.find(params[:building_id])
    add_breadcrumb @building.name, :building_path
  end
end
