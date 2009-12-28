class Settings::SupportingSkillCodesController < SettingsController
  
  before_filter :find_skill_code, :only => [ :edit, :update, :destroy]

  def index
    @skill_codes = SupportingSkillCode.all(:order => :description)
  end

  def new
    @skill_code = SupportingSkillCode.new
    @valid_codes = SupportingSkillCode.valid_codes

    render :action => :edit
  end


  def edit
    @valid_codes = SupportingSkillCode.valid_codes
  end


  def create
    @skill_code = SupportingSkillCode.new(params[:supporting_skill_code])

    if @skill_code.save
      flash[:notice] = "Supporting skill code was successfully created."
      redirect_to :action => :index
    else
      @valid_codes = SupportingSkillCode.valid_codes
      render :action => :edit
    end
  end


  def update
		## If an alternate CODE is provided then use it instead
		if !params[:code1].empty?
			params[:supporting_skill_code][:code] = params[:code1]
		end
    
    if @skill_code.update_attributes(params[:supporting_skill_code])
      flash[:notice] = "Supporting skill code was successfully updated."
      redirect_to :action => :index
    else
      render :action => 'edit'
    end
  end


  def destroy
    if @skill_code.destroy
      flash[:notice] = "Supporting skill code was successfully deleted."
    else
      flash[:error] = "Supporting skill code was not deleted."
    end
    
    redirect_to( supporting_skill_codes_url )
  end

protected
  def find_skill_code
    @skill_code = SupportingSkillCode.find(params[:id])
  end
  
end
