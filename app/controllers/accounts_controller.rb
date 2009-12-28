class AccountsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  before_filter :find_user, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    redirect_back_or_default dashboard_index_url
  end

  def edit
  end

  def update

    # Since we have different types of users (Student, Teacher, etc.)
    # we have to grab the correct parms to update.
    user_params = params[@user[:type].downcase]

    # Don't let the user update key things on their account
    user_params.delete(:first_name)
    user_params.delete(:last_name)
    user_params.delete(:login)

    # Perform the update as usual
    if @user.update_attributes(user_params)
      flash[:notice] = "Account updated!"
      redirect_back_or_default dashboard_index_url
    else
      render :action => :edit
    end
  end
  
protected
  def find_user
    @user = current_user
  end
  
end

