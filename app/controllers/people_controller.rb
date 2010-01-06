class PeopleController < GradesheetController
  include SortHelper
  
  def index
    sort_init 'lastname'
    sort_update
    params[:sort_clause] = sort_clause
    
  
    if params[:search]
      @people = Person.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).paginate  :order => params[:sort_clause], :page => params[:page]
    else
      @people = Person.paginate :order => :lastname, :page => params[:page]
    end    
  end
  
end
