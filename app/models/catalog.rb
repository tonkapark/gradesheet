class Catalog < ActiveRecord::Base
  
  attr_accessible :school, :name, :locked, :catalog_terms_attributes
    
  belongs_to :school
  
  has_many :courses
  has_many :courses_terms, :through => :courses  
  
  has_many  :catalog_terms, :dependent => :destroy
  accepts_nested_attributes_for :catalog_terms, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? }
  
  validates_length_of		:name, :within => 1..20
  validates_uniqueness_of :name, :case_sensitive => false
  validates_associated  :catalog_terms, :message => "are not correct."

  # Find the current school year
  named_scope :current, 
          :include => [:catalog_terms],
          :conditions => ["? BETWEEN catalog_terms.starts_on AND catalog_terms.ends_on", Date.today] 
  

  # Calculate the beginning of the school year by finding the begin date of the
  # first term in the school year
  def starts_on
    self.catalog_terms.sort{|a,b| a.ends_on <=> b.ends_on}.first.starts_on
  end

  # Calculate the end of the school year by finding the end date of the
  # last term in the school year
  def ends_on
    self.catalog_terms.sort{|a,b| a.ends_on <=> b.ends_on}.last.ends_on
  end
  
end