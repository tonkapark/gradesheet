class PersonRole < ActiveRecord::Base
  
  attr_accessible :school, :person, :school_id, :person_id
  
  belongs_to :school
  belongs_to :person
  delegate :full_name, :to => :person
  
  validates_presence_of :school_id, :person_id
   
end
