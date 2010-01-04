# Contains the AuthLogic session information for each user.
class UserSession < Authlogic::Session::Base
  generalize_credentials_error_messages true  # don't give up any info about logins
  logout_on_timeout true                      # default is false
  consecutive_failed_logins_limit 10          # only let them try to log in 10 times
  failed_login_ban_for 30.minutes             # and keep them out for 30 minutes
  
  after_create  :authorize
  after_destroy :deauthorize
  
  private

  # Builds the [:authorize] parameter of the session object.  This information is
  # used to build the menu bar as well as grant access to a particually controller.
  def authorize
    # If this user is an Admin authorize them for everything
    if record.is_admin?
      controller.session[:authorize] = [
        ['Home', 'dashboard'],
        ['Users', 'users'],
        ['', 'administrators'],
        ['', 'students'],
        ['', 'teachers'],
        ['', 'teacher_assistants'],
        ['Courses', 'courses'],
        ['', 'enrollments'],
        ['Course Sections', 'course_sections'],
        ['Assignments', 'assignments'],
        ['Reports', 'reports'],
        ['Admin', 'settings'],
        ['', 'assignment_categories'],
        ['', 'grading_scales'],
        ['', 'imports'],
        ['', 'school_years'],
        ['', 'sites'],
        ['', 'buildings'],
        ['', 'rooms'],
        ['', 'supporting_skills'],
        ['', 'supporting_skill_categories'],
        ['', 'terms'],
      ]
    else
      case record[:type].downcase
      when 'administrator'
        controller.session[:authorize] = [
          ['Home', 'dashboard'],
          ['Reports', 'reports']]        
      when 'teacher'
        controller.session[:authorize] = [
          ['Home', 'dashboard'],
          ['Courses', 'course_sections'],          
          ['', 'course_terms'],          
          ['', 'assignments'],
          ['Reports', 'reports']]
      when 'teacher_assistant'
        controller.session[:authorize] = [
          ['Home', 'dashboard'],
          ['Courses', 'course_sections'],    
          ['', 'course_terms'],              
          ['', 'assignments'],
          ]          
      when 'student'
        controller.session[:authorize] = [
          ['Home', 'dashboard'],
          ['Courses', 'course_sections'],    
          ['', 'course_terms'],             
          ['', 'assignments'],          
          ['My Grades', 'grades']]
      else
        # unknown type of user
        controller.session[:authorize] = [['Home', 'dashboard']]
      end
    end
  end  
   
  # Resets the [:authorize] parameter of the session object to give the user
  # a default menu bar and grant access to basic information only.
  def deauthorize
    controller.session[:authorize] = [['Home', 'dashboard']]
  end
end
