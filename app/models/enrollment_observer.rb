class EnrollmentObserver < ActiveRecord::Observer
  
  def after_create(enrollment)
    enrollment.assignments.each do |a|
      a.assignment_evaluations.create!(:school_id => enrollment.student.school.id, :enrollment_id =>enrollment.id)
    end   
  end
  
end