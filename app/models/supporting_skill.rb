class SupportingSkill < ActiveRecord::Base
  belongs_to :school
  belongs_to  :supporting_skill_category, :counter_cache =>true
  has_many    :course_term_skills
  has_many    :course_terms,  :through => :course_term_skills
  
  validates_presence_of :school_id
  validates_length_of     :description, :within => 1..512
  validates_presence_of   :supporting_skill_category

  named_scope :active, :conditions => { :active => true }
  named_scope :by_category_id, lambda { |*args| {:conditions => {:supporting_skill_category_id => args.first} } }
end
