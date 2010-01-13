ActionController::Routing::Routes.draw do |map|
  
  map.namespace :people, :path_prefix => nil, :name_prefix => nil do |u|
    u.resources :students do |student|
      student.resources :enrollments, :as => 'courses', :member => {:confirm_drop => :get} do |sco|
        sco.resources :assignment_evaluations, :name_prefix => 'sco_', :only => [:index], :as => 'assignments'
      end      
    end    
    u.resources :administrators
    u.resources :teachers
    u.resources :teacher_assistants    
  end
  map.resources	:people, :only => [:index]


  # Settings consists of many different, often unrelated, things.  The most
  # logical way to group them together is to build individual controllers
  # and house them under the Settings "master" controller.  
  map.namespace :settings, :name_prefix => nil do |s|
    s.resources :school_years, :controller => "school_years", :as => "grading_periods"    
    s.resources :grading_scales    
    s.resources :topics#, :has_many => :objectives
    s.resources :sites
    s.resources :imports
    s.resources :assignment_categories,  :as => "assignment_types"
    s.resources :buildings, :has_many => :rooms
  end
  map.resources :settings, :only => [:index]

	# Build the standard routes  
  map.resources :reports  
  map.resources :grades
  
  map.resources :courses  
  map.resources :course_terms, :as => 'course_sections', :member => { :grades => :get, :post_grades => :put }, :has_many => :assignments, :shallow => true
  map.resources :assignments, :only => [:index], :member => { :evaluate => :put }
  
  map.resources :enrollments, :only => [:create]

  map.resources :posts, :as => 'news'
  
  # By default, we want the user to see the "dashboard" page.
  map.root :controller => "dashboard"
  
  
end
