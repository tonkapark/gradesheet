require File.dirname(__FILE__) + '/../test_helper'

class CourseTermSkillTest < ActiveSupport::TestCase
	fixtures :all
	
	def setup
    @course_term = CourseTerm.last
    assert_valid @course_term
	end
	def teardown
	end
	

  test 'assign a valid supporting skill' do
    @course_term.objectives << SupportingSkill.last
    assert_valid @course_term
  end

  test 'assign an invalid supporting skill' do
    ss = SupportingSkill.new(:description => 'INVALID')
      
    assert_raise(ActiveRecord::RecordInvalid) do
      @course_term.objectives << ss
    end
  end

  test 'assign a duplicate supporting skill' do
    @course_term.objectives << SupportingSkill.last
    assert_valid @course_term

    assert_raise(ActiveRecord::RecordInvalid) do
      @course_term.objectives << SupportingSkill.last
    end
  end

end
