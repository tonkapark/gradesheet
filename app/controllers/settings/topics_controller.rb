class Settings::TopicsController < SettingsController
  
  before_filter :find_topic_and_objectives,:only => [:show, :edit]
  before_filter :find_topic, :only => [ :update, :destroy]
  
  def index
    @topics = current_user.school.topics.all
  end

  def show    
  end


  def new
    @topic = current_user.school.topics.new
  end


  def edit    
  end


  def create
    @topic = current_user.school.topics.new(params[:topic])

    if @topic.save
      flash[:notice] = "Topic '#{@topic.name}' was successfully created."
      redirect_to @topic
    else
      render :action => 'new'
    end

  end


  def update
    if @topic.update_attributes(params[:topic])
      flash[:notice] = "Topic '#{@topic.name}' was successfully updated."
      redirect_to @topic
    else
      render :action => 'edit'
    end
  end


  def destroy
    if @topic.destroy
      flash[:notice] = "Topic '#{@topic.name}' was successfully deleted."
    else
      flash[:error] = "Topic '#{@topic.name}' was not deleted."
    end
    
    redirect_to topics_url
  end
  
protected
  def find_topic
    @topic = current_user.school.topics.find(params[:id])
  end
  
  def find_topic_and_objectives
    find_topic
    @objectives = current_user.school.objectives.by_topic_id(params[:id])
  end
  
end
