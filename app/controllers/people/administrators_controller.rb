class People::AdministratorsController < People::BaseController
  
  before_filter :find_administrator, :except => [:index, :new, :create]
  
  def index  
  
    if params[:search]
      @administrators =current_user.school.administrators.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).ascend_by_lastname.paginate :page => params[:page]
    else
      @administrators = current_user.school.administrators.paginate :order => 'lastname', :page => params[:page]
    end
      
  end
  
  def show
  end
  
  def new
    @administrator = current_user.school.administrators.new    
  end
  
  def create
    @administrator = current_user.school.administrators.build(params[:administrator])    
    if @administrator.save
      flash[:notice] = "Successfully created administrator."
      redirect_to @administrator
    else
      render :action => 'new'
    end 
  end
  
  def edit
  end
  
  def update    
    if @administrator.update_attributes(params[:administrator])
      flash[:notice] = "Person  '" + @administrator.full_name + "'  was successfully updated."
      redirect_to @administrator
    else
      render :action => "edit"
    end    
  end
  
  def destroy
    @administrator.destroy
    flash[:notice] = "Person'" + @administrator.full_name + "'  was successfully deleted."
    redirect_to administrators_url
  end
  
protected
  def find_administrator
    @administrator = current_user.school.administrators.find(:first, :conditions => ["(id = ? or code = ?)", params[:id].to_i, params[:id]])
  end
end
