class Person < ActiveRecord::Base
  attr_accessible :school_id, :code, :firstname, :middlename, :lastname, :generation, :gender, :date_of_birth, :primary_phone, :secondary_phone, :email, :user_id
  
  ValidatesDateTime.us_date_format = true
  
  belongs_to :school
  belongs_to :user
  
  before_save :upcase_code
  
  validates_presence_of :firstname, :lastname
  validates_uniqueness_of :code, :scope => :school_id, :allow_blank => true
  validates_format_of :code, :with => /^[\w-]+$/,
                              :message => "cannot contain certain special characters or spaces. Valid(a-z, 0-9, -)",
                              :allow_blank => true
  validates_inclusion_of :generation, :in => GENERATIONS_LIST, :message => " {{value}} is not a valid selection.", :allow_blank => true
  validates_inclusion_of :gender, :in => %w[Male Female], :allow_blank => true
  validates_date :dob, :after => '1 Jan 1900', :before => Proc.new { 1.day.from_now.to_date }, :before_message => 'cannot be in the future.', :allow_nil => true
  validates_length_of :primary_phone, :in => 7..30, :allow_blank => true
  validates_length_of :secondary_phone, :in => 7..30, :allow_blank => true
  validates_format_of  :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i, :allow_nil => true
  
  def date_of_birth
    dob.to_s
  end
  
  def date_of_birth=(date)
      self.dob = date
  end
  
  def to_param
    code
  end  
  
  def name
    firstname + ' ' + lastname
  end
  
  def full_name
    n = firstname
    n += ' ' + middlename[0,1] unless middlename.blank?
    n += ' ' + lastname
    n += ' ' + generation unless generation.blank?
    n
  end
  
  def fullname_last
    n = lastname
    (n += ' ' + generation ) unless generation.blank?
    n += ', ' + firstname 
    n += ' ' + middlename[0,1] unless middlename.blank?
    n
  end
  
    
  HUMANIZED_ATTRIBUTES = {
    :dob => "Birth date"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end      
  
protected

  def upcase_code
    self.code = code.to_s.upcase
  end  
  
  
  
end
