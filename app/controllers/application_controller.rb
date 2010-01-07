# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base  
  include Clearance::Authentication
  helper :all # include all helpers, all the time
 
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e09cdc0512f2d77a60d7ccb4c46775c1'
 
  filter_parameter_logging  :password, :password_confirmation
   
 
  ## Declare exception to handler methods
  rescue_from ActiveRecord::RecordNotFound, :with => :bad_record
#  rescue_from NoMethodError, :with => :show_error
 
  def bad_record
    flash[:warning] = 'Record could not be found.  Please try again.'
    redirect_to :action => :index
  end
  
  def show_error(exception); render :text => exception.message; end
 
  
end