class Users::BaseController < ApplicationController
  before_filter :require_user
  append_before_filter :authorized?
  include SortHelper
  
  before_filter :load_sites, :only => [:new, :edit]

protected
  def load_sites
    @sites = Site.find(:all)
  end  
end
