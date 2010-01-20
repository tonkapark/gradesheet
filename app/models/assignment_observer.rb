class AssignmentObserver < ActiveRecord::Observer
  
  def after_create(assignment)
    assignment.enrollments.each do |e|
      e.assignment_evaluations.create!(:assignment => assignment, :school => assignment.school)
    end  
  end
  
end    