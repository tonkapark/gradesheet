class Room < ActiveRecord::Base
  attr_accessible :building_id, :name, :seats

  belongs_to :building, :counter_cache =>true
  has_many :course_terms
  
  validates_presence_of :name
    
end
