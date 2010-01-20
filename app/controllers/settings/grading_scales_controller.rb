class Settings::GradingScalesController < SettingsController
  
  add_breadcrumb 'Grade Scales', :grading_scales_path
  before_filter :find_scale, :only => [:show, :edit, :update, :destroy]
  add_breadcrumb 'New', :new_grading_scale_path, :only => [:new, :create]
  add_breadcrumb 'Edit', :edit_grading_scale_path, :only => [:edit, :update]   
  
  def index
    @scales = current_user.school.grading_scales.find(:all)
  end

  def show
  end


  def new
    @scale = current_user.school.grading_scales.new
  end

  def edit
  end

  def create
    @scale = current_user.school.grading_scales.new(params[:grading_scale])

    if @scale.save
      flash[:notice] = "Grading scale '#{@scale.name}' was successfully created."
      redirect_to @scale
    else
      render :action => 'new'
    end
  end

  def update
    
    if @scale.update_attributes(params[:grading_scale])
      flash[:notice] = "Grading scale '#{@scale.name}' was successfully updated."
      redirect_to @scale
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @scale.destroy
      flash[:notice] = "Grading scale '#{@scale.name}' was successfully deleted."    
    else
      flash[:error] = "Grading scale '#{@scale.name}' was not deleted."
    end
    
    respond_to do |format|
      format.html { redirect_to( grading_scales_url ) }
    end
  end

protected
  def find_scale
    @scale = current_user.school.grading_scales.find(params[:id])
    add_breadcrumb @scale.name, :grading_scale_path
  end
  
end
