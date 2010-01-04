class PeopleController < GradesheetController
  
  def index
    if params[:search]
      @people = Person.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).ascend_by_lastname.paginate :page => params[:page]
    else
      @people = Person.all
    end
    
  end
  
end
