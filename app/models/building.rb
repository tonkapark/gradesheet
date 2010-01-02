class Building < ActiveRecord::Base
  attr_accessible :site_id, :name, :rooms_attributes
  
  belongs_to :site  
  has_many :rooms,  :dependent => :destroy
  validates_presence_of :name
  
  accepts_nested_attributes_for :rooms, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? }
  
end
