class Users::TeacherAssistantsController < Users::BaseController
  
  before_filter :find_ta, :only => [:edit, :update, :destroy ]
  
  def index
    sort_init 'last_name'
    sort_update
    params[:sort_clause] = sort_clause
    @teacher_assistants = TeacherAssistant.search(params)

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :partial => "users/user_list", :locals => { :users => @teacher_assistants } }
    end
  end

  # We don't really want to show an individual person but rather the listing
  # of all people.
  def show
		redirect_to :action => :index
  end

  def new
    @teacher_assistant = TeacherAssistant.new
    render :action => :edit
  end

  def edit
  end

  def create
    @teacher_assistant = TeacherAssistant.new(params[:teacher_assistant])

    respond_to do |format|
      if @teacher_assistant.save
        flash[:notice] = "Teacher Assistant '#{@teacher_assistant.full_name}' was successfully created."
        format.html { redirect_to(@teacher_assistant) }
        format.xml  { render :xml => @teacher_assistant, :status => :created, :location => @teacher_assistant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @teacher_assistant.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @teacher_assistant.update_attributes(params[:teacher_assistant])
        flash[:notice] = 'TeacherAssistant was successfully updated.'
        format.html { redirect_to(@teacher_assistant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @teacher_assistant.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @teacher_assistant.destroy

    respond_to do |format|
      format.html { redirect_to(teacher_assistants_url) }
      format.xml  { head :ok }
    end
  end
  
protected
  def find_ta
    @teacher_assistant = TeacherAssistant.find(params[:id])
  end  
end
