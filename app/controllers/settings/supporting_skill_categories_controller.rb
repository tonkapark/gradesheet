class Settings::SupportingSkillCategoriesController < SettingsController
  
  before_filter :find_supporting_skills_and_category,:only => [:show, :edit]
  before_filter :find_skill_category, :only => [ :update, :destroy]
  
  def index
    @skill_categories = SupportingSkillCategory.all
  end

  def show    
  end


  def new
    @skill_category = SupportingSkillCategory.new

    render :action => :edit
  end


  def edit    
  end


  def create
    @skill_category = SupportingSkillCategory.new(params[:supporting_skill_category])

    if @skill_category.save
      flash[:notice] = "Supporting skill category '#{@skill_category.name}' was successfully created."
      render :action => :edit
    else
      flash[:error] = "Supporting skill category was not created."
      redirect_to :action => :index
    end

  end


  def update
    if @skill_category.update_attributes(params[:supporting_skill_category])
      flash[:notice] = "Supporting skill category '#{@skill_category.name}' was successfully updated."
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end


  def destroy
    if @skill_category.destroy
      flash[:notice] = "Supporting skill category '#{@skill_category.name}' was successfully deleted."
    else
      flash[:error] = "Supporting skill category '#{@skill_category.name}' was not deleted."
    end
    
    redirect_to :action => :index
  end
  
protected
  def find_skill_category
    @skill_category = SupportingSkillCategory.find(params[:id])
  end
  
  def find_supporting_skills_and_category
    find_skill_category
    @skills = SupportingSkill.by_category_id(params[:id])
  end
  
end
