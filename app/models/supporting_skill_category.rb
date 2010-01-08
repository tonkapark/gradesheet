class SupportingSkillCategory < ActiveRecord::Base
  
  belongs_to :school
  has_many    :supporting_skills
  accepts_nested_attributes_for :supporting_skills, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? }
  
  validates_presence_of :name, :school_id
  validates_length_of :name, :within => 1..50

  named_scope :active, :conditions => { :active => true }
end
