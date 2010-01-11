class Room < ActiveRecord::Base
  attr_accessible :building_id, :name, :seats, :school
  
  belongs_to :school
  belongs_to :building, :counter_cache =>true
  has_many :course_terms
  
  validates_presence_of :name, :seats
  validates_numericality_of	:seats, :greater_than_or_equal_to => 0
    
end
