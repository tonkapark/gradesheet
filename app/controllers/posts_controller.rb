class PostsController < GradesheetController
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]
  
  def index
    @posts = current_user.school.posts.paginate :page => params[:page]
  end
  
  def show
  end
  
  def new
    @post = current_user.school.posts.new
  end
  
  def create
    @post = current_user.school.posts.new(params[:post])
    if @post.save
      flash[:notice] = "Successfully created post."
      redirect_to @post
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated post."
      redirect_to @post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post.destroy
    flash[:notice] = "Successfully destroyed post."
    redirect_to posts_url
  end
  
protected
  def find_post
    @post = current_user.school.posts.find(params[:id])
  end
end
