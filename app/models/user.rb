# Contains the information about the User archtype.  This class is not used
# directly but subclassed for other user types (Teacher, Student, etc.) 
class User < ActiveRecord::Base
  
  belongs_to :person
  delegate :full_name, :to => :person
  
  # Authlogic setup
  acts_as_authentic do |c|
    # Set the timeout to something workable while in development
    c.logged_in_timeout = (RAILS_ENV == 'development' ? 1000.minutes : 10.minutes)
    
    # Turn off the email validation as some students/teachers might not have an address.
    c.validate_email_field = false
  end
  
  validates_format_of  :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i, :allow_nil => true

  

  
end
