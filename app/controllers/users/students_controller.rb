class Users::StudentsController < ApplicationController
	layout "standard"

  def index
    @students = Student.search(params[:search], params[:page])
    @types = User.find_user_types(:all)

    respond_to do |format|
      format.html
      format.js { render :partial => "users/user_list", :locals => { :users => @students }}
    end
  end


  def show
    @student = Student.find(params[:id], :include => :site)

    respond_to do |format|
      format.html # { redirect_to users_path }
    end
  end


  def new
    @student = Student.new

    respond_to do |format|
      format.html # { redirect_to users_path }
    end
  end


  def edit
    @student = Student.find(params[:id])
    
    respond_to do |format|
    	format.html #	{ redirect_to users_path }
    end
  end


  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        flash[:notice] = 'Student was successfully created.'
        format.html { redirect_to(@student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        flash[:notice] = 'Student was successfully updated.'
        format.html { redirect_to(students_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
    end
  end
end
