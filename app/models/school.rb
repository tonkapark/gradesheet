class School < ActiveRecord::Base
  has_many :assignment_categories
  has_many :supporting_skill_categories
  has_many :supporting_skills
  has_many :users
  has_many :courses
  has_many :school_years
  has_many :terms
  has_many :grading_scales
  has_many :sites
  has_many :buildings
  has_many :people
  has_many :students
  has_many :teachers
  has_many :administrators

  
end