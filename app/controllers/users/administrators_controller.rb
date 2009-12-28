class Users::AdministratorsController < Users::BaseController
  
  before_filter :find_administrator, :only => [:edit, :update, :destroy]
  
  def index
    sort_init 'last_name'
    sort_update
    params[:sort_clause] = sort_clause
    @administrators = Administrator.search(params)

    respond_to do |format|
      format.html
      format.js { render :partial => "users/user_list", :locals => { :users => @administrators } }
    end
  end

  def show
		redirect_to :action => :index
  end

  def new
    @administrator = Administrator.new
    render :action => :edit
  end

  def edit
  end

  def create
    @administrator = Administrator.new(params[:administrator])

    respond_to do |format|
      if @administrator.save
        flash[:notice] = "Administrator #{@administrator.full_name}' was successfully created."
        format.html { redirect_to(administrators_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @administrator.update_attributes(params[:administrator])
        flash[:notice] = "Administrator '#{@administrator.full_name}' was successfully updated."
        format.html { redirect_to(administrators_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @administrator.destroy

    respond_to do |format|
      format.html { redirect_to(administrators_url) }
      format.xml  { head :ok }
    end
  end
  
protected
  def find_administrator
    @administrator = Administrator.find(params[:id])
  end  
end
