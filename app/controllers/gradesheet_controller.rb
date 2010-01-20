class GradesheetController < ApplicationController
  before_filter :authenticate  
  
  add_breadcrumb 'Dashboard', :root_path
end
