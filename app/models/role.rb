class Role < ActiveRecord::Base
  
  attr_accessible :name
  
  has_many :person_roles
  has_many :people, :through => :person_roles
    
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
   
end
