module CourseHelper

  # Toggle the value of a checkbox between T and F using AJAX
  def toggle_skill(object)
    remote_function(:url => url_for(object),
      :method   => :put,
      :before   => "Element.show('spinner')",
      :complete => "Element.hide('spinner')",
      :with     => "'skill[' + this.checked + ']=' + this.name")
  end
  
  # Render the list of courses for the current user.  This method is called in
	# several locations throughout the system to let the user choose which Course
	# they want to work with.  It should only show "active" courses in "active"
	# grading terms.
	def show_course_list
    if current_user.type == 'Administrator' || current_user.is_admin?
      @courses = Course.find(:all)
    else
      @courses = Course.active.find_all_by_teacher_id(current_user)
    end
		render :partial => 'course_list', :object => @courses
	end

end