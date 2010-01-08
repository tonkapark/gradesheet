class Settings::SitesController < SettingsController
  
  before_filter :find_site, :only => [:show, :edit, :update, :destroy]
  
  def index
    @sites = current_user.school.sites.all
    
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
    @site = current_user.school.sites.new

    respond_to do |format|
      format.html { render :action => :edit }
    end
  end


  def edit
  end


  def create
    @site = current_user.school.sites.new(params[:site])

    if @site.save
      flash[:notice] = "Campus '#{@site.name}' was successfully created."
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end

  def update

    if @site.update_attributes(params[:site])
      flash[:notice] = "Campus '#{@site.name}' was successfully updated."
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end

  def destroy

    if @site.destroy
      flash[:notice] = "Campus '#{@site.name}' was successfully deleted."
      redirect_to :action => "index"
    end
  end
  
protected
  def find_site
    @site = current_user.school.sites.find(params[:id])
  end
end
