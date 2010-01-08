# Contains the information about the DateRange archtype.  This class is not used
# directly but subclassed for other user types (Terms, School Years, etc.)
class DateRange < ActiveRecord::Base

  belongs_to :school
  validates_presence_of :school_id

end