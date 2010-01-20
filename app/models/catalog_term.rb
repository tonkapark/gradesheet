class CatalogTerm < ActiveRecord::Base
  
  attr_accessible :starts_on, :ends_on, :name, :locked, :catalog
  
  belongs_to  :catalog
  
  validates_length_of		:name, :within => 1..20
  validates_date        :starts_on, :before => :ends_on
  validates_date        :ends_on, :after => :starts_on

  # Grading Terms are set as active or inactive by the school administrator.
  # Editing activities (entering grades, changing courses, etc.) are limited to
  # "active" terms.  Once a term is set as inactive Teachers cannot change
  # anything in that term.
  named_scope :unlocked, :conditions => { :locked => false }

  # The current Grading Term is used as a default value in a lot of places.  Creating
  # a new Course, running a report, etc. all show the user the current term.
  named_scope :current, lambda { || { :conditions => ["? BETWEEN begin_date and end_date ", Date.today] } }
  
end
