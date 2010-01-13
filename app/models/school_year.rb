class SchoolYear < DateRange
  
  attr_accessible :terms_attributes
  
  after_update :save_terms
  
  has_many :courses
  has_many :courses_terms, :through => :courses  
  has_many  :terms, :dependent => :destroy
  accepts_nested_attributes_for :terms, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? }
  
  validates_length_of		:name, :within => 1..20
  validates_uniqueness_of :name, :case_sensitive => false
  validates_associated  :terms, :message => "are not correct."

  # Find the current school year
  named_scope :current, lambda { {
      :select     => "DISTINCT date_ranges.*",
      :conditions => ["? BETWEEN terms_date_ranges.begin_date AND terms_date_ranges.end_date", Date.today],
      :joins      => "INNER JOIN date_ranges terms_date_ranges on terms_date_ranges.school_year_id = date_ranges.id AND terms_date_ranges.type = 'Term' AND date_ranges.type = 'SchoolYear'"
    } }


  # Find all school years that contain active terms
  named_scope :active,
    :select     => "DISTINCT date_ranges.*",
    :joins      => "INNER JOIN date_ranges terms_date_ranges on terms_date_ranges.school_year_id = date_ranges.id AND terms_date_ranges.type = 'Term' AND date_ranges.type = 'SchoolYear'",
    :conditions => ["terms_date_ranges.locked = ? ",  false],
    :order      => "end_date DESC"
  

  # Calculate the beginning of the school year by finding the begin date of the
  # first term in the school year
  def begin_date
    self.terms.sort{|a,b| a.end_date <=> b.end_date}.first.begin_date
  end

  # Calculate the end of the school year by finding the end date of the
  # last term in the school year
  def end_date
    self.terms.sort{|a,b| a.end_date <=> b.end_date}.last.end_date
  end
  
  # Make sure the terms save without validation
  def save_terms
    terms.each do |term|
      term.save(false)
    end
  end
end