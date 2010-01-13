# Contains the details on the grading periods and several date standardizations.
class Term < DateRange
  
  #hack to scope terms by school  
  attr_accessible :school_id
  
  belongs_to  :school_year
  
  validates_length_of		:name, :within => 1..20
  validates_date        :begin_date, :before => :end_date
  validates_date        :end_date, :after => :begin_date

  # Grading Terms are set as active or inactive by the school administrator.
  # Editing activities (entering grades, changing courses, etc.) are limited to
  # "active" terms.  Once a term is set as inactive Teachers cannot change
  # anything in that term.
  named_scope :unlocked, :conditions => { :locked => false }

  # The current Grading Term is used as a default value in a lot of places.  Creating
  # a new Course, running a report, etc. all show the user the current term.
  named_scope :current, lambda { || { :conditions => ["? BETWEEN begin_date and end_date ", Date.today] } }
  
end
