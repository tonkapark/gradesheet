ActionController::Routing::Routes.draw do |map|
  map.resources :rooms

  

  # Authlogic support
  map.resource :account #, :controller => "users"
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  # Since we subclass the Users into different types,
  # we need to build routes for them.
  map.resources	:users
  map.resources	:people
  map.namespace :people, :path_prefix => nil, :name_prefix => nil do |u|
    u.resources :students do |student|
      student.resources :enrollments, :as => 'courses', :member => {:confirm_drop => :get} do |sco|
        sco.resources :assignment_evaluations, :name_prefix => 'sco_', :only => [:index], :as => 'assignments'
      end
      
    end
    
    u.resources :teachers
    u.resources :teacher_assistants
    u.resources :administrators
  end
	
  # Settings consists of many different, often unrelated, things.  The most
  # logical way to group them together is to build individual controllers
  # and house them under the Settings "master" controller.  
  map.namespace :settings, :name_prefix => nil do |s|
    s.resources :school_years, :controller => "school_years", :as => "grading_periods"
    s.resources :events
    s.resources :grading_scales
    s.resources :supporting_skills
    s.resources :supporting_skill_codes
    s.resources :supporting_skill_categories
    s.resources :sites
    s.resources :imports
    s.resources :assignment_categories
    s.resources :buildings, :has_many => :rooms
  end
  map.resources :settings, :only => [:index]

	# Build the standard routes
  map.resources :user_sessions
  map.resources :dashboard
  
  map.resources :reports  
  map.resources :grades

  # We do a couple of "special" things with these routes.  It mostly has to
  # do with AJAX updating and things like that.
  map.resources :evaluations, :member => { :update_grade => :post, :update_skill => :post }
  map.resources :courses, :member => { :add_student => :post, :remove_student => :delete, :toggle_accommodation => :post }
  
  map.resources :course_terms, :as => 'course_sections', :member => { :grades => :get, :post_grades => :put }, :has_many => :assignments, :shallow => true
  map.resources :assignments, :only => [:index], :member => { :evaluate => :put }
  
  map.resources :enrollments, :only => [:create]

  # By default, we want the user to see the "dashboard" page.
  map.root :controller => "dashboard"
end
