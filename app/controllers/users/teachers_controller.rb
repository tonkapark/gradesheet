class Users::TeachersController < ApplicationController
  before_filter :require_user
  append_before_filter :authorized?
  include SortHelper

  def index
    sort_init 'last_name'
    sort_update
    params[:sort_clause] = sort_clause
    @teachers = Teacher.search(params)

    respond_to do |format|
      format.html
      format.js { render :partial => "users/user_list", :locals => { :users => @teachers } }
    end
  end


  # We don't really want to show an individual person but rather the listing
  # of all people.
  def show
		redirect_to :action => :index
  end


  def new
    @teacher = Teacher.new
    render :action => :edit
  end


  def edit
    @teacher = Teacher.find(params[:id])
  end


  def create
    @teacher = Teacher.new(params[:teacher])

    respond_to do |format|
      if @teacher.save
        flash[:notice] = "Teacher #{@teacher.full_name}' was successfully created."
        format.html { redirect_to(teachers_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        flash[:notice] = "Teacher '#{@teacher.full_name}' was successfully updated."
        format.html { redirect_to(teachers_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to(teachers_url) }
      format.xml  { head :ok }
    end
  end
end
