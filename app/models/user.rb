class User < ActiveRecord::Base
  include Clearance::User
  
  attr_accessible :person_id, :admin, :invite_id
  
  before_save :downcase_email
  
  belongs_to :person
  delegate :full_name, :to => :person
    
  validates_format_of  :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i



protected

  def downcase_email
    self.email = email.to_s.downcase
  end

end
