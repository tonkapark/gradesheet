class Settings::QuickCommentsController < SettingsController
  
  before_filter :find_qc, :only => [:show, :edit, :update, :destroy]
  
  def index
    @quick_comments = QuickComment.all
  end

  def show
    
  end


  def new
    @quick_comment = QuickComment.new

    render :action => :edit
  end


  def edit
    
  end


  def create
    @quick_comment = QuickComment.new(params[:quick_comment])

    if @quick_comment.save
      flash[:notice] = "Quick comment was successfully created."
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end

  def update

    if @quick_comment.update_attributes(params[:quick_comment])
      flash[:notice] = "Quick comment was successfully updated."
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end

  def destroy

    if @quick_comment.destroy
      flash[:notice] = "Quick comment was successfully deleted."
      redirect_to :action => "index"
    end
  end
  
protected
  def find_qc
    @quick_comment = QuickComment.find(params[:id])
  end
end
