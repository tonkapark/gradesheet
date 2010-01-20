class PeopleController < GradesheetController
    
  add_breadcrumb 'People', :people_path
  
  def index    
    if params[:search]
      
    else
      @students = current_user.school.students.find(:all, :limit => 5, :order => 'created_at desc')
      @teachers = current_user.school.teachers.find(:all, :limit => 5, :order => 'created_at desc')
      @administrators = current_user.school.administrators.find(:all,  :limit => 5, :order => 'created_at desc' )
    end
  end
    
end
