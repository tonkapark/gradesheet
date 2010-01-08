class Settings::SupportingSkillsController < SettingsController
  
  before_filter :load_category, :only => [:index, :new, :create]
  before_filter :find_skill_and_category, :except => [:index, :new, :create]
  
  def index    
    @skills = @category.supporting_skills.all
  end

  def show
  end


  def new
    @skill = @category.supporting_skills.new
  end


  def edit    
  end


  def create
    @skill = @category.supporting_skills.build(params[:supporting_skill])
    if @skill.save
      flash[:notice] = "Supporting skill was successfully created."
      redirect_to @category
    else
      render :action => 'new'
    end

    
  end


  def update
    if @room.update_attributes(params[:room])
      flash[:notice] = "Successfully updated skill."
      redirect_to @category
    else
      render :action => 'edit'
    end
  end



  def destroy
    @room.destroy
    flash[:notice] = "Successfully destroyed room."
    redirect_to @category
  end
  
protected
  def find_skill_and_category
    load_category
    @skill = @category.supporting_skills.find(params[:id])
  end
  
  def load_category
    @category = current_user.school.supporting_skill_categories.find(params[:suporting_skill_category_id])
  end
  

end
