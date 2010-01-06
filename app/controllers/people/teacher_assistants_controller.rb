class People::TeacherAssistantsController < People::BaseController
  
  before_filter :find_ta, :only => [:show, :edit, :update, :destroy ]
  
  def index
    sort_init 'lastname'
    sort_update
    params[:sort_clause] = sort_clause
    
    if params[:search]
      @teacher_assistants = TeacherAssistant.code_or_firstname_or_lastname_like_any(params[:search].to_s.split).paginate  :order => params[:sort_clause], :page => params[:page]
    else
      @teacher_assistants = TeacherAssistant.paginate :order => params[:sort_clause], :page => params[:page]
    end       

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :partial => "people/user_list", :locals => { :people => @teacher_assistants } }
    end
  end

  def show
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
    @teacher_assistant = TeacherAssistant.find_by_code!(params[:id])
  end  
end
