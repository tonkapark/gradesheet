class DashboardController < GradesheetController
  
  def index
    @posts = current_user.school.posts.published.paginate :page => params[:page]
  end
  
end
