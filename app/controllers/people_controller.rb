class PeopleController < GradesheetController
    
  #before_filter :find_person, :except => [:index, :new, :create]
  
  def index    
    if params[:search]
      
    else
      @students = current_user.school.students.find(:all, :limit => 5, :order => 'created_at desc')
      @teachers = current_user.school.teachers.find(:all, :limit => 5, :order => 'created_at desc')
      @administrators = current_user.school.administrators.find(:all,  :limit => 5, :order => 'created_at desc' )
    end
  end
  
  #~ def show
  #~ end
  
  #~ def new
    #~ @person = current_user.school.people.new    
  #~ end
  
  #~ def create
    #~ @person = current_user.school.people.build(params[:person])
    #~ @person.roles = Role.find(params[:role_ids]) if params[:role_ids]
    #~ if @person.save
      #~ flash[:notice] = "Successfully created person."
      #~ redirect_to @person
    #~ else
      #~ render :action => 'new'
    #~ end 
  #~ end
  
  #~ def edit
  #~ end
  
  #~ def update
    #~ @person.roles = Role.find(params[:role_ids]) if params[:role_ids]
    #~ if @person.update_attributes(params[:person])
      #~ flash[:notice] = "Person  '" + @person.full_name + "'  was successfully updated."
      #~ redirect_to @person
    #~ else
      #~ render :action => "edit"
    #~ end    
  #~ end
  
  #~ def destroy
    #~ @person.destroy
    #~ flash[:notice] = "Person'" + @person.full_name + "'  was successfully deleted."
    #~ redirect_to people_url
  #~ end
  
#~ protected
  #~ def find_person
    #~ @person = current_user.school.people.find(:first, :conditions => ["(id = ? or code = ?)", params[:id].to_i, params[:id]])
  #~ end
    
end
