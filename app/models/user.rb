class User < ActiveRecord::Base
  include Clearance::User
  
  attr_accessible :person_id, :admin
  
  before_save :downcase_email
  
  belongs_to :person
  delegate :full_name, :to => :person

protected

  def downcase_email
    self.email = email.to_s.downcase
  end

end
