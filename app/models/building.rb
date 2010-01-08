class Building < ActiveRecord::Base
  
  attr_accessible :school, :site_id, :name, :rooms_attributes
  
  belongs_to :school
  belongs_to :site  
  has_many :rooms,  :dependent => :destroy
  accepts_nested_attributes_for :rooms, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? }
  
  validates_presence_of :name, :school_id
  
end
