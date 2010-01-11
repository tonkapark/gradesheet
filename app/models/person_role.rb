class PersonRole < ActiveRecord::Base
  
  attr_accessible :role, :person, :role_id, :person_id, :school, :school_id
  
  belongs_to :school
  belongs_to :role
  belongs_to :person
  delegate :full_name, :to => :person
  
  validates_presence_of :role_id, :person_id
   
end
