class Post < ActiveRecord::Base
  attr_accessible :school_id, :title, :body, :active, :published_at
  
  belongs_to :school

  before_validation :published  
  validates_existence_of :school
  validates_presence_of :title, :body
  
  named_scope :published, :conditions => [ 'published_at < ? and active = ?', Time.zone.now, true]
  
  cattr_reader :per_page
  @@per_page = 10

 
  def published
    #self.published_at ||= Time.now unless self.is_active == 0
    unless self.active?
      unless self.published_at.blank?
          self.published_at = nil
      end
    else
      if self.published_at.blank?
          self.published_at = Time.now
      end
    end
  end
  
end
