class School < ActiveRecord::Base
  has_many :assignment_categories
  has_many :assignment_evaluations
  has_many :assignments
  has_many :users
  has_many :courses
  has_many :course_terms
  has_many :catalogs
  has_many :grading_scales
  has_many :scale_ranges
  has_many :sites
  has_many :buildings
  has_many :rooms, :through=> :buildings
  has_many :people
  has_many :students
  has_many :teachers
  has_many :administrators
  has_many :posts
  
end
