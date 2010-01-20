class DashboardController < ApplicationController
  before_filter :authenticate  
  
  def index
    @posts = current_user.school.posts.published.limited(5)   
    
    
    unless current_user.person.class.name == 'Administrator'
      @course_terms = current_user.person.course_terms.limited(5)
      @assignments = current_user.person.assignments.limited(15).month_group
    else
      @course_terms = current_user.school.course_terms.limited(5)
      @assignments = current_user.school.assignments.limited(15).month_group
    end
    
    
  end
  
end
