class Settings::GradingScalesController < SettingsController
 
  before_filter :find_scale, :only => [:show, :edit, :update, :destroy]

  def index
    @scales = GradingScale.find(:all)
  end

  def show
  end


  def new
    @scale = GradingScale.new
    5.times{ @scale.scale_ranges.build }  # Create a couple of grade ranges as a default

    render :action => :edit
  end


  def edit
  end


  def create
    @scale = GradingScale.new(params[:grading_scale])

    if @scale.save
      flash[:notice] = "Grading scale '#{@scale.name}' was successfully created."
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def update
    params[:grading_scale][:existing_range_attributes] ||= {}

    if @scale.update_attributes(params[:grading_scale])
      flash[:notice] = "Grading scale '#{@scale.name}' was successfully updated."
      redirect_to :action => :index
    else
      render :action => :edit
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
    @scale = GradingScale.find(params[:id])
  end
  
end
