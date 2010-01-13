# Contains the minimum & maximum grades possible and their letter scores.
class ScaleRange < ActiveRecord::Base

  belongs_to  :grading_scale

  validate :min_less_than_max, :unless => Proc.new { |scale| scale.min_score.nil? || scale.max_score.nil? }
    
  validates_length_of       :description, :within => 0..250
  validates_length_of       :letter_grade, :within => 1..20

  validates_numericality_of :max_score, :greater_than_or_equal_to => 0, :allow_blank => true
  validates_numericality_of :min_score, :greater_than_or_equal_to => 0, :allow_blank => true
  validates_uniqueness_of :letter_grade, :scope => :grading_scale_id

  def min_less_than_max
    # Make sure that the minimum score is less than the maximum score
    errors.add_to_base("Minimum Score cannot be greater than Maximum Score") if min_score > max_score      
  end


end
