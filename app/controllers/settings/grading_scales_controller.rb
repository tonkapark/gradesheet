class Settings::GradingScalesController < SettingsController
 
  before_filter :find_scale, :only => [:show, :edit, :update, :destroy]

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
  end
  
end
