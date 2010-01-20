class Site < ActiveRecord::Base
  before_destroy  :ensure_no_children

	belongs_to :school
  has_many :buildings
  has_many :rooms, :through => :buildings
	
	validates_size_of        :name, :within => 1..40
  validates_uniqueness_of  :name, :case_sensitive => false
  
private

  # Ensure that the user does not delete a record without first cleaning up
  # any records that use it.  This could cause a cascading effect, wiping out
  # more data than expected.	
	def ensure_no_children
		unless self.buildings.empty?
			self.errors.add_to_base "Cannot delete campus while buildings and rooms are still activly used."
			raise ActiveRecord::Rollback
		end
	end

end
