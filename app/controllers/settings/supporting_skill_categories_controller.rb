class Settings::SupportingSkillCategoriesController < SettingsController
  
  before_filter :find_supporting_skills_and_category,:only => [:show, :edit]
  before_filter :find_skill_category, :only => [ :update, :destroy]
  
  def index
    @skill_categories = current_user.school.supporting_skill_categories.all
  end

  def show    
  end


  def new
    @skill_category = current_user.school.supporting_skill_categories.new
  end


  def edit    
  end


  def create
    @skill_category = current_user.school.supporting_skill_categories.new(params[:supporting_skill_category])

    if @skill_category.save
      flash[:notice] = "Supporting skill category '#{@skill_category.name}' was successfully created."
      redirect_to @skill_category
    else
      render :action => 'new'
    end

  end


  def update
    if @skill_category.update_attributes(params[:supporting_skill_category])
      flash[:notice] = "Supporting skill category '#{@skill_category.name}' was successfully updated."
      redirect_to @skill_category
    else
      render :action => 'edit'
    end
  end


  def destroy
    if @skill_category.destroy
      flash[:notice] = "Supporting skill category '#{@skill_category.name}' was successfully deleted."
    else
      flash[:error] = "Supporting skill category '#{@skill_category.name}' was not deleted."
    end
    
    redirect_to supporting_skill_categories_url
  end
  
protected
  def find_skill_category
    @skill_category = current_user.school.supporting_skill_categories.find(params[:id])
  end
  
  def find_supporting_skills_and_category
    find_skill_category
    @skills = current_user.school.supporting_skills.by_category_id(params[:id])
  end
  
end
