class User < ActiveRecord::Base
  include Clearance::User
  
  attr_accessible :school, :person, :admin
  
  before_save :downcase_email
  
  belongs_to :school
  belongs_to :person
  delegate :full_name, :to => :person

  validates_presence_of :school_id, :person_id

protected

  def downcase_email
    self.email = email.to_s.downcase
  end

end
