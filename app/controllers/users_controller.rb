# FIXME: Meld all the sub-controllers (Students, Teachers, TA) into this controller
class UsersController < ApplicationController
  before_filter :require_user
  append_before_filter :authorized?
  include SortHelper

  def index
    sort_init 'last_name'
    sort_update
    params[:sort_clause] = sort_clause
    @users = User.search(params)
  end

  # We don't really want to show an individual person but rather the listing
  # of all people.
  def show
		redirect_to :action => :index
  end


  def impersonate
    @user = User.find(params[:id])

    if UserSession.create(@user)
      flash[:warning] = "You are now impersonating '#{@user.full_name}'."
      redirect_to root_url
    else
      flash[:error] = "Impersonation failed."
      render :action => :show
    end
  end
  
end
