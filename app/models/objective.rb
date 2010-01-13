class Objective < ActiveRecord::Base
  
  belongs_to  :topic, :counter_cache =>true
  has_many    :course_term_skills
  has_many    :course_terms,  :through => :course_term_skills
  
  validates_length_of     :description, :within => 1..512
  validates_presence_of   :topic

  named_scope :active, :conditions => { :active => true }
  named_scope :by_topic_id, lambda { |*args| {:conditions => {:topic_id => args.first} } }
end
