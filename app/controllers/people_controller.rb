class PeopleController < GradesheetController
    
  before_filter :find_person, :except => [:index, :new, :create]
  
  def index  
  
    if params[:search]
      @people =current_user.school.people.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).ascend_by_lastname.paginate :page => params[:page]
    else
      if params[:role]
        @people = current_user.school.people.paginate :joins => "LEFT JOIN person_roles ON person_roles.person_id = people.id", :conditions => ["person_roles.type = ?", params[:role]], :order => 'lastname', :page => params[:page]
      else
        @people = current_user.school.people.paginate :order => 'lastname', :page => params[:page]
      end
      
    end    
  end
  
  def show
  end
  
  def new
    @person = current_user.school.people.new
  end
  
  def create
    @person = current_user.school.people.build(params[:student])
    
    if @person.save
      flash[:notice] = "Successfully created person."
      redirect_to @person
    else
      render :action => 'new'
    end 
  end
  
  def edit
  end
  
  def update
    if @person.update_attributes(params[:person])
      flash[:notice] = "Person  '" + @person.full_name + "'  was successfully updated."
      redirect_to @person
    else
      render :action => "edit"
    end    
  end
  
  def destroy
    @person.destroy
    flash[:notice] = "Person'" + @person.full_name + "'  was successfully deleted."
    redirect_to people_url
  end
  
protected
  def find_person
    @person = current_user.school.people.find(:first, :conditions => ["(id = ? or code = ?)", params[:id].to_i, params[:id]])
  end
    
end
