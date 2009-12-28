# This class handles all the static data in the application.  It allows us to
# efficiently use the same data in different parts of the application and persist
# it to the database as needed.
class StaticData < ActiveRecord::Base
  set_table_name  "static_data"

  before_save :upcase_name

  validates_length_of :value, :in => 1..40
  validates_uniqueness_of :name

  named_scope :defaults, :conditions => { :name => ['TAG_LINE','SITE_NAME']}


  # SITE_NAME  
  def self.site_name
    return lookup('SITE_NAME')
  end

  # TAG_LINE
  def self.tag_line 
    return lookup('TAG_LINE')
  end

protected

  def upcase_name
    self.name = name.to_s.upcase
  end
  
private
  # Get the static value from the database
  def self.lookup(name)
    StaticData.find_by_name(name).value
  end
  
end

